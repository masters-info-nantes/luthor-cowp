{

  open Parser
  open Lexing
  
  (** Increments the lexing buffer line number counter.*)
  let incr_line lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      {pos with pos_lnum = pos.pos_lnum + 1; pos_bol = 0}
  
  (** Increments the lexing buffer line offset by the given length. *)
  let incr_bol lexbuf length =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <- {pos with pos_bol = pos.pos_bol + length}
    
  (** Increments the lexing buffer line offset by the given lexem length. *)
  let incr_bol_lxm lexbuf lxm = incr_bol lexbuf (String.length lxm)
  
  (** Turns a char into a string containing this char. *)
  let string_of_char c = String.make 1 c
  
}

let identifier  = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*
let string      = '"' [^'"']* '"'
let integer     = ['0'-'9']+
let number      = integer ('.' integer)?
let operation   = ['0'-'9' '+' '-' '*' '/' '(' ')']+

rule main = parse
  | "="                         {incr_bol lexbuf 1; EQUAL}
  | "CONST"     | "Const"       {incr_bol lexbuf 5; CONST}
  | "IF"        | "If"	        {incr_bol lexbuf 2 ; IF}
  | "FOR"       | "For"	        {incr_bol lexbuf 3 ; FOR}
  | "TO"        | "To"	        {incr_bol lexbuf 2 ; TO}
  | "DO"        | "Do"	        {incr_bol lexbuf 2 ; DO}
  | "LOOP"      | "Loop"	    {incr_bol lexbuf 4 ; LOOP}
  | "WHILE"     | "While"	    {incr_bol lexbuf 5 ; WHILE}
  | "NEXT"      | "Next"	    {incr_bol lexbuf 4 ; NEXT}
  | "END"       | "End"	        {incr_bol lexbuf 3 ; END}
  | "THEN"      | "Then"        {incr_bol lexbuf 4 ; THEN}
  | "ELSE"      | "Else"        {incr_bol lexbuf 4 ; ELSE}
  | "DIM"       | "Dim"	        {incr_bol lexbuf 3 ; DIM}
  | "STRING"    | "String"      {incr_bol lexbuf 6; TYPE_STRING}
  | "INTEGER"   | "Integer"     {incr_bol lexbuf 7; TYPE_INTEGER}
  | "AS"        | "As"          {incr_bol lexbuf 2; AS}
  | "PRINT"     | "Print"       {incr_bol lexbuf 5; PRINT}
  | '\n'                        {incr_line lexbuf ; EOL}
  | ' '         | '\t'          {incr_bol lexbuf 1;main lexbuf}
  | eof   {EOF}
  
  | "<" | ">" | "<=" | ">=" as str{incr_bol_lxm lexbuf str; COMPARATOR str}
  | identifier as str           {incr_bol_lxm lexbuf str; IDENTIFIER str}
  | string as str               {incr_bol_lxm lexbuf str; STRING str}
  | number as str               {incr_bol_lxm lexbuf str; NUMBER str}
  
  | operation as str            {incr_bol_lxm lexbuf str; OPERATION str}

  
  | _ as c                      {Error.error ("Unrecognized character " ^ (string_of_char c)) lexbuf.lex_curr_p}
