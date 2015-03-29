%{
  let texte = open_out "compiled.c"
  let () = output_string texte "#include<stdio.h> \n\n"

    (** Overrides the default parse_error function. *)  
    
  let parse_error s = Error.warning "Parsing error" (symbol_start_pos ())

%}

%token <string> STRING
%token <string> INTEGER
%token <string> NUMBER
%token <string> PRIM_TYPE
%token <string> IDENTIFIER
%token TYPE_STRING
%token TYPE_INTEGER

%token DIM
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
%token EQUAL
%token GTHAN
%token LTHAN

%token COMMA
%token <string> OPERATION
%token EOF


%start init
%type <string> init
%%

init:
	EOF {""}
	| PRINT STRING init{"printf(" ^ $2 ^ ");\n" ^ $3}
	| DIM IDENTIFIER AS TYPE_STRING init{"char* " ^ $2 ^ ";\n"}
;
