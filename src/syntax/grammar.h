#pragma once

#ifndef TOKEN_TYPES_DEFINED
#define TOKEN_TYPES_DEFINED


typedef enum{
    // Single-character tokens.
    TOKEN_LEFT_PAREN,
    TOKEN_RIGHT_PAREN,
    TOKEN_LEFT_BRACE,
    TOKEN_RIGHT_BRACE,
    TOKEN_COMMA,
    TOKEN_COLON,
    TOKEN_DOT,
    TOKEN_MINUS,
    TOKEN_PLUS,
    TOKEN_SLASH,
    TOKEN_STAR,
    TOKEN_PERCENT,
    TOKEN_NEWLINE,
    TOKEN_SEMICOLON,

    // One or two character tokens.
    TOKEN_BANG,
    TOKEN_BANG_EQUAL,
    TOKEN_EQUAL,
    TOKEN_IS,
    TOKEN_EQUAL_EQUAL,
    TOKEN_GREATER,
    TOKEN_GREATER_EQUAL,
    TOKEN_LESS,
    TOKEN_LESS_EQUAL,
    TOKEN_PLUS_EQUAL,
    TOKEN_MINUS_EQUAL,
    TOKEN_STAR_EQUAL,
    TOKEN_SLASH_EQUAL,
    TOKEN_PERCENT_EQUAL,
    TOKEN_PLUS_PLUS,
    TOKEN_MINUS_MINUS,

    // Literals.
    TOKEN_IDENTIFIER,
    TOKEN_STRING,
    TOKEN_NUMBER,

    // Keywords.
    TOKEN_AND,
    TOKEN_OR,
    TOKEN_CLASS,
    TOKEN_TRUE,
    TOKEN_FALSE,
    TOKEN_FOR,
    TOKEN_FUNC,
    TOKEN_IF,
    TOKEN_ELSE,
    TOKEN_NULL,
    TOKEN_WRITE,
    TOKEN_ASK,
    TOKEN_RETURN,
    TOKEN_ADOPT,
    TOKEN_THIS,
    TOKEN_THE,
    TOKEN_WHILE,

    // ERROR AND EOF
    TOKEN_ERROR,
    TOKEN_EOF,
} TokenType;

// Token struct
typedef struct{
    TokenType type;
    const char *start;
    int length;
    int line;
} Token;

void initGrammer(const char *source); // Initialize the grammar
Token scanToken(); // Scan a token

#endif