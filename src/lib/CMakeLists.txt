include("${PROJECT_SOURCE_DIR}/toolchains/compiler-flags.cmake")
add_library(testl test-lib.c)
target_include_directories(testl PUBLIC  "${PROJECT_BINARY_DIR}" "${PROJECT_SOURCE_DIR}/src/lib/include")