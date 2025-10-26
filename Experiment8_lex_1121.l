%{
#include "y.tab.h"
%}

digit   [0-9]

%%

[ \t]+          ;   // ignore whitespace
{digit}+        { yylval = atoi(yytext); return NUMBER; }
[\n]            { return '\n'; }
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"("             { return '('; }
")"             { return ')'; }
.               { printf("Unknown character: %s\n", yytext); }

%%
