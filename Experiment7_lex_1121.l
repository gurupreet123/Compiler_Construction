%{
#include "y.tab.h"
%}

%%

[0-9]+   {
    int val = 0, i;
    for (i = 0; yytext[i] != '\0'; i++)
        val = val * 10 + (yytext[i] - '0');
    yylval = val;
    return NUM;
}

[ \t\n]   ;               
.         { return yytext[0]; }  

%%

int yywrap(void) { return 1; }
