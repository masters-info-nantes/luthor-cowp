%{

%}

%token <string> STRING
%token PRINT
%token EOF


%start init
%type <string> init
%%


init:
	EOF {""}
	| PRINT STRING init{"printf(" ^ $2 ^ ");\n" ^ $3}
;
