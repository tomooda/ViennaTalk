parsers-literals
characterLiteral
	^ (($' asParser , (self char / $" asParser) , $' asParser) ==> #second) trim