cmake_minimum_required(VERSION 3.20)
project(autoprintf CXX)

find_package(Clang REQUIRED CONFIG)

message(STATUS "Found Clang ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using ClangConfig.cmake in: ${LLVM_DIR}")
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})

#llvm_map_components_to_libnames(llvm_libs support core)

add_library(HelloWorld SHARED HelloWorld.cpp)

install(TARGETS HelloWorld)

include(CTest)
