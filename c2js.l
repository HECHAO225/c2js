/* c2js flex flie */
Digit 	[0-9]
Letter 	[a-zA-Z]
Hex 	[a-fA-F0-9]
FS      (f|F|l|L)
E           [Ee][+-]?{Digit}+

%{
#include <iostream>
#include <fstream>

#define YYSTYPE char*

using namespace std;

extern "C"
{
    void yyerror(const char* s);
    extern int yylex(void);
}

void showStr();
%}

%%
"//"            { showStr(); } 
"char"          { showStr(); }
"double"        { showStr(); }
"float"         { showStr(); }
"for"           { showStr(); }
"while"         { showStr(); }
"if"            { showStr(); }
"int"           { showStr(); }
"return"        { showStr(); }
"void"          { showStr(); }
"#include"      { showStr(); }


{Digit}*"."{Digit}+({E})?{FS}?  { showStr(); }
{Digit}+"."{Digit}*({E})?{FS}?  { showStr(); }
{Digit}              			{ showStr(); }

"++"            { showStr();  }
"--"            { showStr();  }
"<="            { showStr(); }
">="            { showStr(); }
"=="            { showStr(); }
"!="            { showStr(); }
"&&"            { showStr();  }
"||"            { showStr(); }
"-"             { showStr(); }
"+"             { showStr(); }
"*"             { showStr(); }
"/"             { showStr(); }
"%"             { showStr(); }
"\\"            { showStr(); }
"<"             { showStr(); }
"."             { showStr(); }
">"             { showStr(); }
","             { showStr(); }
":"             { showStr(); }
";"             { showStr(); }
"="             { showStr(); }
"("             { showStr(); }
")"             { showStr(); }
"{"     		{ showStr(); }
"}"      		{ showStr(); }
"["      		{ showStr(); }
"]"      		{ showStr(); }
"\""			{ showStr(); }

[a-zA-Z][a-zA-Z0-9]*  { cout<<"identifier: "; showStr(); }

[\n]                  ;
[a-zA-Z][a-zA-Z0-9]*  printf("Var     : %s\n",yytext);
[/+/%/*///-]          printf("Op      : %s\n",yytext);
[0-9]+                printf("Int     : %s\n",yytext);
[0-9]*[/.][0-9]+      printf("Float   : %s\n",yytext);

[ \t\v\n\f] 		  { }
.                     printf("Unknown : %c\n",yytext[0]);

%%


void showStr()
{
	cout<<yytext<<endl;

}

int main()
{
	yylex(); /* 进行分析 */
	return 0;
}

int yywrap()
{
	return 1;
}