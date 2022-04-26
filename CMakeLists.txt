cmake_minimum_required(VERSION 3.9 FATAL_ERROR)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
#######################################################################
#                               Project                               #
#######################################################################
project(MatrixProduct LANGUAGES CUDA CXX)

# Create Main project
set(SOURCES
	mm.cu
)

set(HEADERS
)

add_executable(main
	${SOURCES}
	${HEADERS}
)


include(CheckLanguage)
check_language(CUDA)



#######################################################################
#                              Benchmark                              #
#######################################################################
add_subdirectory(${PROJECT_SOURCE_DIR}/benchmark)



#######################################################################
#                                Test                                 #
#######################################################################
add_subdirectory(${PROJECT_SOURCE_DIR}/tests)

