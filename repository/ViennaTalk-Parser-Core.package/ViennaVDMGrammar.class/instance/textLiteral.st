parsers-literals
textLiteral
	^ (($" asParser , (self char star ==> [ :chars | String withAll: chars ]) , $" asParser) ==> #second) trim