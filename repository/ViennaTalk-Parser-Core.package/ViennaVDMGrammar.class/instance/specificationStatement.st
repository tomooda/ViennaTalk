parsers-statements
specificationStatement
	^ (lbracket , self implicitOperationBody , rbracket) ==> #second