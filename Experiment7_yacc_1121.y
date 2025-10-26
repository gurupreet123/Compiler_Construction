%{
#include <stdio.h>
#include <stdlib.h>

int result;
int valid = 1;

int yylex(void);
int yyerror(const char *s);
%}

%token NUM

%%

input:
    expr    { result = $1; }
  ;

expr:
      expr expr '+'   { $$ = $1 + $2; }
    | expr expr '-'   { $$ = $1 - $2; }
    | expr expr '*'   { $$ = $1 * $2; }
    | expr expr '/'   { $$ = $1 / $2; }
    | NUM             { $$ = $1; }
;

%%

int main() {
    printf("Enter a postfix expression:\n");
    if (yyparse() == 0 && valid) {
        printf("Valid expression.\n");
        printf("Result = %d\n", result);
    } else {
        printf("Invalid expression.\n");
    }
    return 0;
}

int yyerror(const char *s) {
    valid = 0;
    return 0;
}
