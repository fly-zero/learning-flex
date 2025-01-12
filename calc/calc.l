%option noyywrap

%{
#include <stdlib.h>

#include "calc.tab.h"

extern int yylval;
%}

%%

[0-9]+         { yylval = atoi(yytext); return NUMBER; }
0x[0-9a-fA-F]+ { yylval = strtol(yytext, NULL, 16); return NUMBER; }
[-+*/()\n]     { return yytext[0]; }  // 加減乗除、括弧、换行原样返回
[ \t]          { }
.              { fprintf(stderr, "Unknown charactor: %s\n", yytext); yyterminate(); } 

%%
