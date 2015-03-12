{
	open Interpret_parser
	
	  (* Open the lexing module to update lexbuf position. *)
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

let type  	= "Integer"|"Double"|"String"
let privacy = "private"|"public"|"protected"
let integer  = ['0'-'9']+
let number   = integer ('.' integer)?
let string = '\"'_*'\"'
let identifier = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse
  | "/*" {comment lexbuf}
  (* | "//"[^'\n']*'\n' {SINGLE_COM}
  | integer as i {INTEGER i}
  | number {NUMBER}
  | type as i{PRIM_TYPE i}
  | privacy {PRIVACY} *)
  | "PRINT" {incr_bol lexbuf 4; PRINT}
  | "DIM" {incr_bol lexbuf 3; DIM}
  | "AS"	{incr_bol lexbuf 2; AS}
  | string as i{incr_bol_lxm lexbuf i ; STRING i}
  | identifier as i{incr_bol_lxm lexbuf i ; IDENTIFIER i}
  (*| '(' {incr_bol lexbuf 1; BEGIN_PAR}
  | ')' {incr_bol lexbuf 1; END_PAR}
  | '{' {incr_bol lexbuf 1; BEGIN_CURL}
  | '}' {incr_bol lexbuf 1; END_CURL}
  | ';' {incr_bol lexbuf 1; SEMICOLON}
  | '+' {incr_bol lexbuf 1; PLUS}
  | '-' {incr_bol lexbuf 1; MINUS}
  | '*' {incr_bol lexbuf 1; MUL}
  | '/' {incr_bol lexbuf 1; DIV}
  | '^' {incr_bol lexbuf 1; POW}
  | '=' {incr_bol lexbuf 1; EQUAL}
  | "class" {CLASS} *)

  (* New line *)
  | '\n' {incr_line lexbuf ; token lexbuf}
  (* Skip cariage return *)
  | '\r' {token lexbuf}
  (* White space *)
  | ' ' | '\t' {incr_bol lexbuf 1 ; token lexbuf}
  
  | eof {EOF}
  (* Raise an exception with all unknown characters *)
  | _ as c {Error.warning ("Unrecognized character " ^ (string_of_char c)) lexbuf.lex_curr_p;incr_bol lexbuf 1 ;token lexbuf}
  
and comment = parse
  | "*/" {token lexbuf}
  | _    {comment lexbuf}
  | eof  {EOF}
