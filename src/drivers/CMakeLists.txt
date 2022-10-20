include("${PROJECT_SOURCE_DIR}/toolchains/compiler-flags.cmake")
add_library(testd test-driver.c)
target_include_directories(testd PUBLIC  "${PROJECT_BINARY_DIR}" "${PROJECT_SOURCE_DIR}/src/drivers/include")