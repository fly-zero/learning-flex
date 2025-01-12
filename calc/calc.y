%{
#include <stdio.h>

extern int yylex();

void yyerror();
%}

%token NUMBER

%%

calclist:
        | calclist '\n'
        | calclist expr '\n' { printf("Result: %d\n", $2); }
        ;

expr: factor { $$ = $1; }
    | expr '+' factor { $$ = $1 + $3; }
    | expr '-' factor { $$ = $1 - $3; }
    ;

factor: term { $$ = $1; }
      | factor '*' term { $$ = $1 * $3; }
      | factor '/' term { $$ = $1 / $3; }
      ;

term: NUMBER { $$ = $1; }
    | '(' expr ')' { $$ = $2; }
    ;

%%

void yyerror(const char *s)
{
    fprintf(stderr, "error: %s\n", s);
}

int main()
{
    yyparse();
}
