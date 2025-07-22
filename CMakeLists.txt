cmake_minimum_required(VERSION 3.20)
project(autoprintf CXX)

find_package(Clang REQUIRED CONFIG)
find_package(LLVM REQUIRED CONFIG)

#message(STATUS "Found Clang ${Clang_PACKAGE_VERSION}")
message(STATUS "Using ClangConfig.cmake in: ${Clang_DIR}")
message(STATUS "CLANG_INCLUDE_DIRS: ${CLANG_INCLUDE_DIRS}")

message(STATUS "LLVM Version: ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "LLVM_INCLUDE_DIRS: ${LLVM_INCLUDE_DIRS}")

include_directories(${CLANG_INCLUDE_DIR};${LLVM_INCLUDE_DIRS})

separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})

#llvm_map_components_to_libnames(llvm_libs support core)

add_library(HelloWorld SHARED HelloWorld.cpp)

install(TARGETS HelloWorld)

include(CTest)
