%{
#include <stdio.h>

size_t nchars = 0;
size_t nwords = 0;
size_t nlines = 0;
%}

%%

[a-zA-Z]+ { ++nwords; nchars += strlen(yytext); }
\n        { ++nlines; ++nchars; }
.         { ++nchars; }

%%

int yywrap()
{
    return 1;
}

int main()
{
    yylex();
    printf("nchars: %lu\n", nchars);
    printf("nwords: %lu\n", nwords);
    printf("nlines: %lu\n", nlines);
}
