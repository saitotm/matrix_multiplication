#######################################################################
#                                Test                                 #
#######################################################################

enable_testing()
add_executable( test_all EXCLUDE_FROM_ALL testa.cpp )

function(print_list TITLE LIST)
	message(STATUS "##### ${TITLE} #####")
	foreach(ITEM ${LIST})
		message(STATUS "${ITEM}")
	endforeach()
	message("")
endfunction()

file(GLOB LIST "*")
print_list("GLOB only" "${LIST}")

if(OpenMP_CXX_FOUND)
	target_link_libraries(test_all PUBLIC OpenMP::OpenMP_CXX)
endif()

find_package(GTest REQUIRED)
target_link_libraries(test_all PRIVATE GTest::GTest GTest::Main)

