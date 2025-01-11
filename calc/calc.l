%{
#include <stdlib.h>

#include "calc.tab.h"

extern int yylval;
%}

%%

[0-9]+ { yylval = atoi(yytext); return NUMBER; }
[-+*/] { return yytext[0]; }
\n     { return '\n'; } // returns '\n' to indicate the end of expression
[ \t]  { }
.      { fprintf(stderr, "Unknown charactor: %s\n", yytext); yyterminate(); } 

%%

int yywrap()
{
    return 1;
}
