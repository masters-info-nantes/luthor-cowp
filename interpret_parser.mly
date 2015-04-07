%{
    open Definitions
%}

%token <string> STRING
%token <string> INTEGER
%token <string> NUMBER
%token <string> PRIM_TYPE
%token <string> IDENTIFIER
%token TYPE_STRING
%token TYPE_INTEGER

%token DIM
%token CONST
%token AS
%token IF 
%token THEN 
%token ELSE 
%token IFEND 
%token FOR
%token TO
%token NEXT
%token WHILE
%token DO
%token LOOP
%token PRINT
%token DEQUAL
%token EQUAL
%token GTHAN
%token LTHAN

%token COMMA
%token PLUS
%token LESS
%token TIMES
%token DIVIDE
%token EOF


%start init
%type <string> init
%%

init:
	expressions EOF {""}
;

expressions:
    expressions expression {$2::$1}
;

expression:
    | print{$1}
    | affectation{$1}
;

print:
    | PRINT STRING {"printf(" ^ $2 ^ ");\n"}
;

affectation:
    | IDENTIFIER EQUAL NUMBER{$1 ^ " = " ^ $3}
;

comparator:
	| DEQUAL { "==" }
	| GTHAN { ">" }
	| GTHAN EQUAL { ">=" }
	| LTHAN { "<" }
	| LTHAN EQUAL { "<=" }
;

operator:
    | PLUS { "+" }
    | LESS { "-" }
    | TIMES { "*" }
    | DIVIDE { "/" }
;
