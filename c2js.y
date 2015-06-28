/* c2js bison flie */
%{
#include <iostream>
#include <fstream>
using namespace std;
#define YYSTYPE string

extern "C"
{
    void yyerror(const char* s);
    extern int yylex(void);
    ofstream outfile("out.js", ios::out);
}

int tabNum = 0;

%}

%token IDENTIFIER CONSTANT STRING_LITERAL
%token INC_OP DEC_OP AND_OP OR_OP LE_OP GE_OP EQ_OP NE_OP
%token VOID CHAR INT FLOAT DOUBLE

%token IF FOR RETURN WHILE COMMENT COMMENTLONG
%token INCLUDE
%start program

%%

program
    : {$$ = "";}
    | program program_unit {outfile << $2 << "\n";}
    ;

program_unit
    : include_declaration  {$$ = $1;}
    | function_declaration {$$ = $1;}
    | declaration          {$$ = $1;}
    | comment              {$$ = $1;}
    ;

include_declaration
    : INCLUDE '<' IDENTIFIER '.' IDENTIFIER '>' {$$ = '';}
    | INCLUDE '<' IDENTIFIER '>'                {$$ = '';}
    ;

comment
    : COMMENT string {$$ = $1 + $2;}
    ;

string
    : primary_expression            {$$ = $1}
    | primary_expression string     {$$ = $1 + " " + $2}
    ;

primary_expression
    : IDENTIFIER
    {
        if ($1 == "printf")
            $$ = "console.log";
        else
            $$ = $1;
    }
    | CONSTANT          {$$ = $1;}
    | STRING_LITERAL    {$$ = $1;}
    ;

function_declaration
    : type_specifier declarator compound_statement





















    