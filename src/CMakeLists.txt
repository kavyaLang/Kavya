cmake_minimum_required(VERSION 3.10)
project(LexerTest)

find_package(FLEX REQUIRED)

set(SYNTAX_DIR ${CMAKE_CURRENT_SOURCE_DIR}/syntax)

if(NOT EXISTS ${SYNTAX_DIR}/lexer.l)
    message(FATAL_ERROR "Lexer file not found: ${SYNTAX_DIR}/lexer.l")
endif()

FLEX_TARGET(KavyaLexer
    ${SYNTAX_DIR}/lexer.l
    ${CMAKE_CURRENT_BINARY_DIR}/lex.yy.c
)

# Create a library for the lexer
add_library(lexer_lib ${FLEX_KavyaLexer_OUTPUTS})

# Disable `-Werror` for `lex.yy.c`
set_source_files_properties(${FLEX_KavyaLexer_OUTPUTS} PROPERTIES COMPILE_FLAGS "-Wno-unused-function")

target_include_directories(lexer_lib PRIVATE ${SYNTAX_DIR})

# Set C standard
set_property(TARGET lexer_lib PROPERTY C_STANDARD 11)
