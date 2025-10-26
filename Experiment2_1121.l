%{
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
 
int sc = 0, wc = 0, lc = 0, cc = 0;
 int keyword_count = 0, identifier_count = 0, comment_count = 0, tab_count = 0;
 
char *keywords[] = {
    "auto", "break", "case", "char", "const", "continue", "default", "do", "double",
 "else", 
    "enum", "extern", "float", "for", "goto", "if", "inline", "int", "long", "register",
 "restrict",
    "return", "short", "signed", "sizeof", "static", "struct", "switch", "typedef",
 "union", 
    "unsigned", "void", "volatile", "while"
 };
 
int is_keyword(char *word) {
    for (int i = 0; i < sizeof(keywords)/sizeof(keywords[0]); i++) {
        if (strcmp(word, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
 }
 %}
 
%%
 
"/*"([^*]|\*+[^*/])*\*+"/"   { comment_count++; cc += yyleng; }
 "//".*                                  { comment_count++; cc += yyleng; }
 [\n]                                    { lc++; cc += yyleng; }
 " "                                     { sc++; cc += yyleng; }
 "\t"                                    { tab_count++; cc += yyleng; }
 [^\t\n ]+                    {
                                wc++;
                                cc += yyleng;
                                if (is_keyword(yytext)) {
                                    keyword_count++;
                                } else if (isalpha(yytext[0]) || yytext[0] == '_') {
                                    identifier_count++;
                                }
                            }
 
%%
 
int main(int argc, char* argv[]) {
    printf("Enter the input:\n");
    yylex();
    printf("The number of lines = %d\n", lc);
    printf("The number of spaces = %d\n", sc);
    printf("The number of tabs = %d\n", tab_count);
    printf("The number of words = %d\n", wc);
    printf("The number of characters = %d\n", cc);
    printf("The number of keywords = %d\n", keyword_count);
    printf("The number of identifiers = %d\n", identifier_count);
    printf("The number of comments = %d\n", comment_count);
    return 0;
 }
 
int yywrap() {
    return 1;
 }
