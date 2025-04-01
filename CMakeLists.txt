cmake_minimum_required(VERSION 3.10)

project(kavya 
    VERSION 1.0.0
    DESCRIPTION "Kavya Project"
    LANGUAGES C
)

find_package(Git REQUIRED)
find_program(FLEX_EXECUTABLE flex REQUIRED)
find_program(BISON_EXECUTABLE bison REQUIRED)
find_program(CLANG_EXECUTABLE clang REQUIRED)
find_program(LLVM_CONFIG_EXECUTABLE llvm-config REQUIRED)

find_program(GCC_EXECUTABLE gcc REQUIRED)
find_program(MAKE_EXECUTABLE make REQUIRED)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -O2 -Wall -Wextra -Wpedantic -Werror")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=native -flto")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fstack-protector-strong -D_FORTIFY_SOURCE=2")

option(ENABLE_DEBUG "Enable debug build" OFF)

include_directories(
    ${PROJECT_SOURCE_DIR}/include/kavya
)

# Add the `src` directory
add_subdirectory(src)

# Gather all source files
file(GLOB SOURCES "${PROJECT_SOURCE_DIR}/src/*.c")

# Link the lexer library
add_executable(${PROJECT_NAME} ${SOURCES})
target_link_libraries(${PROJECT_NAME} lexer_lib -lfl)

install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
)

add_custom_target(run
    COMMAND ${PROJECT_NAME}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Running ${PROJECT_NAME}"
    VERBATIM
)

if(ENABLE_DEBUG)
    target_compile_definitions(${PROJECT_NAME} PRIVATE DEBUG=1)
    message(STATUS "Debug mode enabled")
endif()
