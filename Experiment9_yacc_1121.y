%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
extern char *yytext;
%}

%union {
    int num;
    char *str;
}

%token <num> NUMBER
%token ID
%token FOR LPAREN RPAREN SEMICOLON ASSIGN
%token LT GT LE GE EQ NE
%token PLUS MINUS MULT DIV
%token INC DEC
%token LBRACE RBRACE
%token INT FLOAT CHAR DOUBLE

%left PLUS MINUS
%left MULT DIV

%%

program:
      for_stmt
    ;

for_stmt:
      FOR LPAREN init SEMICOLON condition SEMICOLON increment RPAREN body
        { printf("Valid FOR loop statement parsed.\n"); }
    ;

init:
      datatype ID ASSIGN expr
    | ID ASSIGN expr
    ;

datatype:
      INT
    | FLOAT
    | CHAR
    | DOUBLE
    ;

condition:
      expr LT expr
    | expr GT expr
    | expr LE expr
    | expr GE expr
    | expr EQ expr
    | expr NE expr
    ;

increment:
      ID ASSIGN expr
    | ID INC
    | ID DEC
    | INC ID
    | DEC ID
    ;

body:
      statement
    | LBRACE statements RBRACE
    ;

statements:
      /* empty */
    | statements statement
    ;

statement:
      expr SEMICOLON
    | for_stmt
    ;

expr:
      NUMBER
    | ID
    | expr PLUS expr
    | expr MINUS expr
    | expr MULT expr
    | expr DIV expr
    | ID INC
    | ID DEC
    | INC ID
    | DEC ID
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s near '%s'\n", s, yytext);
}

int main() {
    printf("Enter a FOR loop statement:\n");
    yyparse();
    return 0;
}

