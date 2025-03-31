cmake_minimum_required(VERSION 3.10)
project(LexerTest)

find_package(FLEX REQUIRED)

# Set source directories
set(SYNTAX_DIR ${CMAKE_CURRENT_SOURCE_DIR}/syntax)

# Verify lexer file exists
if(NOT EXISTS ${SYNTAX_DIR}/lexer.l)
    message(FATAL_ERROR "Lexer file not found: ${SYNTAX_DIR}/lexer.l")
endif()

# Configure Flex
FLEX_TARGET(KavyaLexer
    ${SYNTAX_DIR}/lexer.l
    ${CMAKE_CURRENT_BINARY_DIR}/lex.yy.c
)

# Create executable to run the lexer
add_executable(lexer_test ${FLEX_KavyaLexer_OUTPUTS})

# Add include directories needed for lexer.l (if any)
target_include_directories(lexer_test PRIVATE ${SYNTAX_DIR})

# Set C standard
set_property(TARGET lexer_test PROPERTY C_STANDARD 11)