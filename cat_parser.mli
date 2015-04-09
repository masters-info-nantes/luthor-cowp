type token =
  | IDENTIFIER of (string)
  | NUMBER of (string)
  | COMPARATOR of (string)
  | EOL
  | AS
  | TYPE_INTEGER
  | TYPE_STRING
  | STRING of (string)
  | PRINT
  | EOF
  | DIM
  | IF
  | DO
  | LOOP
  | WHILE
  | END
  | EQUAL
  | THEN
  | ELSE
  | FOR
  | TO
  | NEXT
  | CHAR of (char)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit
