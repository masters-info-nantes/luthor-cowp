%{
  let texte = open_out "compiled.c"
  let () = output_string texte "#include<stdio.h> \n\n"

    (** Overrides the default parse_error function. *)  
    
  let parse_error s = Error.warning "Parsing error" (symbol_start_pos ())

%}

%token <string> STRING
%token TYPE_STRING
%token DIM
%token AS
%token <string> PRIM_TYPE
%token PRINT
%token <string> IDENTIFIER
%token EOF


%start init
%type <string> init
%%

init:
	EOF {""}
	| PRINT STRING init{"printf(" ^ $2 ^ ");\n" ^ $3}
	| DIM IDENTIFIER AS TYPE_STRING init{"char* " ^ $2 ^ ";\n"}
;
