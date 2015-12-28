parsers-literals
symbolicLiteral
	^ (comment star , self basicSymbolicLiteral , comment star) ==> #second