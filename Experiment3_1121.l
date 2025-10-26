%{
#include <stdio.h>
int cap_a_count = 0;     
int small_a_count = 0;   
%}

%%

A[a-zA-Z0-9_]*   { cap_a_count++; }     
a[a-zA-Z0-9_]*   { small_a_count++; }
[^ \t\n]+        { /* Ignore other words */ }
[ \t\n]+         { /* Skip spaces */ }

%%

int main()
{
    printf("Enter the input text (Ctrl+D to end):\n");
    yylex();
    printf("\nNumber of words starting with 'A' = %d\n", cap_a_count);
    printf("Number of words starting with 'a' = %d\n", small_a_count);
    printf("Total words starting with 'A' or 'a' = %d\n", cap_a_count + small_a_count);
    return 0;
}

int yywrap() 
{ 
return 1; 
}
