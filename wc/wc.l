%option noyywrap

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

static void print_header()
{
    printf("%8s %8s %8s\n", "lines", "words", "chars");
}

int main(int argc, char **argv)
{
    if (argc > 1) {
        size_t total_chars = 0;
        size_t total_words = 0;
        size_t total_lines = 0;

        print_header();

        for (int i = 1; i < argc; ++i) {
            FILE *f = fopen(argv[i], "r");
            if (!f) {
                fprintf(stderr, "error: cannot open file %s, %m\n", argv[i]);
                return 1;
            }

            yyrestart(f);
            yylex();
            fclose(f);

            printf("%8lu %8lu %8lu %s\n", nlines, nwords, nchars, argv[i]);

            total_chars += nchars; nchars = 0;
            total_words += nwords; nwords = 0;
            total_lines += nlines; nlines = 0;
        }

        printf("%8lu %8lu %8lu total\n", total_lines, total_words, total_chars);
    } else {
        yylex();
        print_header();
        printf("%8lu %8lu %8lu\n", nlines, nwords, nchars);
    }
}
