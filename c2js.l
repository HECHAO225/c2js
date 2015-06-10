/* c2js flex flie */
Digit [0-9]
Letter [a-zA-Z]
Hex [a-fA-F0-9]

%{
#include <iostream>
#include <fstream>
#include "c2js.tab.h"

#define YYSTYPE char*

using namespace std;

extern "C"
{
    void yyerror(const char* s);
    extern int yylex(void);
}

void read();
%}

%%
