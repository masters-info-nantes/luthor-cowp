EXEC = b2c

CAMLC = ocamlc
CAMLDEP = ocamldep
CAMLLEX = ocamllex
CAMLYACC = ocamlyacc

all:
	$(CAMLLEX) interpret_lexer.mll
	$(CAMLYACC) interpret_parser.mly
	$(CAMLC) -c interpret_parser.mli
	$(CAMLC) -c interpret_parser.ml
	$(CAMLC) -c interpret_lexer.ml
	$(CAMLC) interpret_lexer.cmo interpret_parser.cmo interpret.ml -o $(EXEC)

clean:
	rm -f *.cm[iox] *.mli *~ .*~
	rm -rf interpret_lexer.ml interpret_parser.ml

