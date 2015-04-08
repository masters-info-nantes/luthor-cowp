type token =
  | IDENTIFIER of (string)
  | NUMBER of (string)
  | EOL
  | AS
  | TYPE_INTEGER
  | TYPE_STRING
  | STRING of (string)
  | PRINT
  | EOF
  | DIM
  | IF
  | END
  | EQUAL
  | GTHAN
  | LTHAN
  | THEN
  | ELSE
  | CHAR of (char)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit
