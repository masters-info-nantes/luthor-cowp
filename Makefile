EXEC = cat

CAMLC = ocamlc
CAMLLEX = ocamllex
CAMLYACC = ocamlyacc

all:
	$(CAMLLEX) cat_scanner.mll
	$(CAMLYACC) cat_parser.mly
	$(CAMLC) -c cat_parser.mli
	$(CAMLC) -c error.ml
	$(CAMLC) -c definitions.ml
	$(CAMLC) -c cat_parser.ml
	$(CAMLC) -c cat_scanner.ml
	$(CAMLC) error.cmo definitions.cmo  cat_scanner.cmo cat_parser.cmo cat.ml -o $(EXEC)

clean:
	rm -f *.cm[iox] *.mli *~ .*~ #*#
	rm -f $(EXEC)
	rm -f $(EXEC).opt
	rm -rf cat_scanner.ml cat_parser.ml
