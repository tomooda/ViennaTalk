parsers-literals
textLiteral
	^ (($" asParser , ((self char / $' asParser) star ==> [ :chars | String withAll: chars ]) , $" asParser) ==> #second)
		trim