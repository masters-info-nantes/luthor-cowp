%{
	let parse_error s = Error.error "Parsing error" (symbol_start_pos ())
    open Definitions
%}

%token <string> IDENTIFIER
%token <string> NUMBER
%token <string> COMPARATOR
%token EOL
%token AS
%token TYPE_INTEGER
%token TYPE_STRING
%token <string> STRING
%token PRINT
%token EOF
%token DIM
%token IF
%token DO
%token LOOP
%token WHILE
%token END
%token EQUAL
%token THEN
%token ELSE
%token FOR
%token TO
%token NEXT
%token <char> CHAR
%start main
%type <unit> main
%%

/*
 * A file is a list of characters ending with the end of file token. When
 * the end of the file is reached, we just print a new line.
 */
main:
   expressions EOF {print_newline ()}
;

expressions:
    /* empty */ {}
  | expressions EOL {print_string "\n"}
  | expressions affectations{}
  | expressions print_expr{}
  | expressions condition{}
  | expressions loop{}
;

loop:
    | expressions FOR IDENTIFIER EQUAL NUMBER TO NUMBER{print_string "for(int ";print_string $3;print_string "=";print_string $5;print_string ";";print_string $3;print_string "<";print_string $7;print_string ";";print_string $3;print_string "++){"}
    | expressions NEXT { print_string "}"}
    | expressions DO WHILE IDENTIFIER EQUAL NUMBER{print_string "while(";print_string $4;print_string "==";print_string $6;print_string "){"}
    | expressions DO WHILE IDENTIFIER COMPARATOR NUMBER{print_string "while(";print_string $4;print_string $5;print_string $6;print_string "){"}
    | expressions DO { print_string "while(1){"}
    | expressions LOOP { print_string "}"}
;

condition:
	| expressions IF predicate THEN{print_string "if(";print_string $3;print_string "){"}
	| expressions END IF{ print_string "}"}
	| expressions ELSE IF predicate THEN{print_string " }else if(";print_string $4; print_string "){ "}
;

predicate:
	| IDENTIFIER EQUAL STRING {$1 ^ " == " ^ $3}
    
	| IDENTIFIER EQUAL NUMBER {$1 ^ " == " ^ $3}
	| IDENTIFIER COMPARATOR NUMBER {$1 ^ $2 ^ $3}
    
    | IDENTIFIER EQUAL IDENTIFIER {$1 ^ " == " ^ $3}
	| IDENTIFIER COMPARATOR IDENTIFIER {$1 ^ $2 ^ $3}
;

print_expr:
  | expressions PRINT IDENTIFIER {print_variable $3}
  | expressions PRINT STRING {print_string "printf(" ;print_string $3;print_string ");"}
;

affectations:
	| expressions DIM IDENTIFIER AS TYPE_STRING {print_string "char* ";print_string $3;print_string ";"; add_var $3 "String"}
	| expressions DIM IDENTIFIER AS TYPE_INTEGER {print_string "int ";print_string $3;print_string ";"; add_var $3 "Integer"}
;
