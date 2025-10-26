%{
#include <stdio.h>;
#include <ctype.h> // For toupper() and tolower()
%}

%%
[a-z] { printf(“%c”, toupper(yytext[0])); }
[A-Z] { printf(“%c”, tolower(yytext[0])); }
.         { printf(“%s”, yytext); }

%%

int main() {
printf(“Enter the input text :\n”);
yylex();
return 0;
}

int yywrap() {
return 1;
}
