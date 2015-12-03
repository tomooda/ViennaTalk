parsers-patterns
mapEnumerationPattern
	^ (lbrace , ((mapletArrow ==> [ :single | Array new ]) / (self mapletPattern separatedBy: comma) withoutSeparators)
		, rbrace) ==> #second