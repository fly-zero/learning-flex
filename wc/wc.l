%{
#include <stdio.h>
#include <stdlib.h>

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

int main(int argc, char **argv)
{
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Cannot open file: %s, %m\n", argv[1]);
            exit(EXIT_FAILURE);
        }
    }

    yylex();
    printf("nchars: %lu\n", nchars);
    printf("nwords: %lu\n", nwords);
    printf("nlines: %lu\n", nlines);
}
