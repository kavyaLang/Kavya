%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "grammar.h"

    int current_line = 1;
    char* process_string(const char* text);

    typedef union {
        int ival;
        char *sval;
    } YYSTYPE;

    YYSTYPE yylval; // Declare yylval
%}

%option noyywrap

/* Regex patterns */
DIGIT         [0-9]
LETTER        [a-zA-Z_]
ID            {LETTER}({LETTER}|{DIGIT})*
STRING        \"([^"\\]|\\.)*\"
NUMBER        {DIGIT}+(\.{DIGIT}+)?([eE][+-]?{DIGIT}+)?

WHITESPACE    [ \t\f\r]+
NEWLINE       \n

%%

{WHITESPACE}    { /* Ignore whitespace */ }
{NEWLINE}       { /* Do nothing for now */  }  /*  current_line++; return TOKEN_NEWLINE; */

"("             { return TOKEN_LEFT_PAREN; }
")"             { return TOKEN_RIGHT_PAREN; }
"{"             { return TOKEN_LEFT_BRACE; }
"}"             { return TOKEN_RIGHT_BRACE; }
","             { return TOKEN_COMMA; }
"."             { return TOKEN_DOT; }
"-"             { return TOKEN_MINUS; }
"+"             { return TOKEN_PLUS; }
";"             { return TOKEN_SEMICOLON; }
"/"             { return TOKEN_SLASH; }
"*"             { return TOKEN_STAR; }

"!="            { return TOKEN_BANG_EQUAL; }
"=="            { return TOKEN_EQUAL_EQUAL; }
"<="            { return TOKEN_LESS_EQUAL; }
">="            { return TOKEN_GREATER_EQUAL; }

"and"           { return TOKEN_AND; }
"or"            { return TOKEN_OR; }
"class"         { return TOKEN_CLASS; }
"else"          { return TOKEN_ELSE; }
"false"         { return TOKEN_FALSE; }
"true"          { return TOKEN_TRUE; }
"for"           { return TOKEN_FOR; }
"func"          { return TOKEN_FUNC; }
"if"            { return TOKEN_IF; }
"null"          { return TOKEN_NULL; }
"write"         { return TOKEN_WRITE; }
"return"        { return TOKEN_RETURN; }
"adopt"         { return TOKEN_ADOPT; }
"this"          { return TOKEN_THIS; }
"the"           { return TOKEN_THE; }
"while"         { return TOKEN_WHILE; }

{ID}            { yylval.sval = strdup(yytext); return TOKEN_IDENTIFIER; }
{STRING}        { yylval.sval = process_string(yytext); return TOKEN_STRING; }
{NUMBER}        { yylval.ival = atoi(yytext); return TOKEN_NUMBER; }

.              { fprintf(stderr, "Error at line %d: Unexpected character '%s'\n",
                            current_line, yytext);
                return TOKEN_ERROR; } // Added semicolon

%%

char* process_string(const char* text){
    size_t len = strlen(text);
    if (len < 2) return NULL;

    char *result = malloc(len - 1);
    if (!result) return NULL;

    strncpy(result, text + 1, len - 2);
    result[len - 2] = '\0';
    return result;
}

int main() {
    int token;
    printf("Enter a Token: ");
    while ((token = yylex())) {
        if (token == TOKEN_IDENTIFIER) {
            printf("IDENTIFIER: %s\n", yylval.sval);
            free(yylval.sval); // Free the allocated memory
        } else if (token == TOKEN_NUMBER) {
            printf("NUMBER: %d\n", yylval.ival);
        } else if (token == TOKEN_STRING) {
            printf("STRING: %s\n", yylval.sval);
            free(yylval.sval); // Free the allocated memory
        } else {
            printf("TOKEN: %d\n", token);
        }
        printf("Enter a Token: ");
    }
    return 0;
}
