parsers-literals
textLiteral
	^ (($" asParser , (char star ==> [ :chars | String withAll: chars ]) , $" asParser) ==> #second) trim