#include "kavya.h"
#include "syntax/grammar.h"

typedef union {
    int ival;
    char *sval;
} YYSTYPE;

YYSTYPE yylval; 
extern int yylex();
extern char* yytext;

int main() {
    
    int token;
    printf("Enter a Token: ");
    while ((token = yylex())) {
        if (token == TOKEN_IDENTIFIER) {
            printf("IDENTIFIER: %s\n", yylval.sval);
            free(yylval.sval); 
        } else if (token == TOKEN_NUMBER) {
            printf("NUMBER: %d\n", yylval.ival);
        } else if (token == TOKEN_STRING) {
            printf("STRING: %s\n", yylval.sval);
            free(yylval.sval); 
        } else {
            printf("TOKEN: %d\n", token);
        }
        printf("Enter a Token: ");
    }
    
    return 0;
}
