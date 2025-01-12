%{
#include <stdlib.h>

#include "calc.tab.h"

extern int yylval;
%}

%%

[0-9]+         { yylval = atoi(yytext); return NUMBER; }
0x[0-9a-fA-F]+ { yylval = strtol(yytext, NULL, 16); return NUMBER; }
[-+*/]         { return yytext[0]; }
\n             { return '\n'; } // returns '\n' to indicate the end of expression
[ \t]          { }
.              { fprintf(stderr, "Unknown charactor: %s\n", yytext); yyterminate(); } 

%%

int yywrap()
{
    return 1;
}
