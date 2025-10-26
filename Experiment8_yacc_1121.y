%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

%}

%token NUMBER

%left '+' '-'
%left '*' '/'
%right UMINUS

%%
input:
    /* empty */
    | input line
    ;

line:
    '\n'
    | expr '\n'     { printf("Result = %d\n", $1); }
    | error '\n'   { yyerror("Syntax error recovered."); yyclearin; }
    ;

expr:
    NUMBER           { $$ = $1; }
    | expr '+' expr  { $$ = $1 + $3; }
    | expr '-' expr  { $$ = $1 - $3; }
    | expr '*' expr  { $$ = $1 * $3; }
    | expr '/' expr  {
        if ($3 == 0) {
            yyerror("Error: division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
      }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | '(' expr ')'   { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter expressions:\n");
    return yyparse();
}
