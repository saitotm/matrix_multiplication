#######################################################################
#                              Benchmark                              #
#######################################################################

add_executable( bench_xxx EXCLUDE_FROM_ALL bench_xxx.cpp )

if(OpenMP_CXX_FOUND)
	target_link_libraries(bench_xxx PUBLIC OpenMP::OpenMP_CXX)
endif()

find_package(benchmark REQUIRED)
target_link_libraries(bench_xxx PRIVATE benchmark::benchmark)
