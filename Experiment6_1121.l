%{
#include <stdio.h>
int line_number = 1;
%}
%%
.*com\n {
printf(“Line %d ends with ‘com’: “, line_number, yytext);
line_number++;
}
\n {
line_number++;
}
.|\t { /* Consume other characters */ }
%%
int main() {
yylex();
return 0;
}
int yywrap() {
return 1;
}
