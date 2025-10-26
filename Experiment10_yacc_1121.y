%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 0;
int yylex(void);
void yyerror(const char *s);
%}

%union {
    char *str;
}

%token <str> ID NUMBER
%left '+' '-'
%left '*' '/'
%type <str> expr

%%

input:
      /* empty */
    | input expr '\n' { printf("\n"); free($2); }
    ;

expr:
      expr '+' expr {
            $$ = (char *)malloc(20);
            sprintf($$, "t%d", ++tempCount);
            printf("%s = %s + %s\n", $$, $1, $3);
            free($1); free($3);
      }
    | expr '-' expr {
            $$ = (char *)malloc(20);
            sprintf($$, "t%d", ++tempCount);
            printf("%s = %s - %s\n", $$, $1, $3);
            free($1); free($3);
      }
    | expr '*' expr {
            $$ = (char *)malloc(20);
            sprintf($$, "t%d", ++tempCount);
            printf("%s = %s * %s\n", $$, $1, $3);
            free($1); free($3);
      }
    | expr '/' expr {
            $$ = (char *)malloc(20);
            sprintf($$, "t%d", ++tempCount);
            printf("%s = %s / %s\n", $$, $1, $3);
            free($1); free($3);
      }
    | ID      { $$ = strdup($1); free($1); }
    | NUMBER  { $$ = strdup($1); free($1); }
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter arithmetic expressions (Ctrl+D to end):\n");
    yyparse();
    return 0;
}

