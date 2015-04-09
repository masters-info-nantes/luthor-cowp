EXEC = b2c

CAMLC = ocamlc
CAMLLEX = ocamllex
CAMLYACC = ocamlyacc

all:
	$(CAMLLEX) scanner.mll
	$(CAMLYACC) parser.mly
	$(CAMLC) -c parser.mli
	$(CAMLC) -c error.ml
	$(CAMLC) -c definitions.ml
	$(CAMLC) -c parser.ml
	$(CAMLC) -c scanner.ml
	$(CAMLC) error.cmo definitions.cmo  scanner.cmo parser.cmo b2c.ml -o $(EXEC)

clean:
	rm -f *.cm[iox] *.mli *~ .*~ #*#
	rm -f $(EXEC)
	rm -f $(EXEC).opt
	rm -rf scanner.ml parser.ml
