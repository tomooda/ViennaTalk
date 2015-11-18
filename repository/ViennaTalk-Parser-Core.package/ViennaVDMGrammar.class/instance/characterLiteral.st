parsers-literals
characterLiteral
	^ (($' asParser , self char , $' asParser) ==> #second) trim