{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      autoprintf =
        {
          clangStdenv,
          libclang,
          llvm,
          cmake,
          ninja,
          lib,
        }:
        clangStdenv.mkDerivation {
          name = "autoprintf";
          buildInputs = [
            libclang
            llvm
          ];
          nativeBuildInputs = [
            cmake
            ninja
          ];
          src = lib.cleanSource ./.;
        };
    in
    {
      packages = forAllSystems (system: {
        autoprintf = nixpkgs.legacyPackages.${system}.callPackage autoprintf { };
        default = self.packages.${system}.autoprintf;
      });

      devShells = forAllSystems (
        system:
        let
          pkg = self.packages.${system}.autoprintf;
        in
        {
          autoprintf =
            with nixpkgs.legacyPackages.${system};
            mkShell.override
              {
                stdenv = pkg.stdenv;
              }
              {
                inputsFrom = [ pkg ];
                packages = [
                  lldb
                  clang-tools
                ];
                hardeningDisable = [ "all" ];
                CMAKE_EXPORT_COMPILE_COMMANDS = "ON";
              };
          default = self.devShells.${system}.autoprintf;
        }
      );
    };
}
