let () =
  	if Array.length Sys.argv < 3
    	then print_endline "Please provide input and output file"
	else
  		let input_file = Sys.argv.(1) in
  		if not (Sys.file_exists input_file)
    		then print_endline "This file does not exist"
    	else
    		let output_file = open_out Sys.argv.(2) in
  			let lexbuf = Lexing.from_channel (open_in input_file) in
				let contents = Interpret_parser.init Interpret_lexer.token lexbuf in
				output_string output_file contents;
				output_char output_file '\n';
				close_out output_file
          	
