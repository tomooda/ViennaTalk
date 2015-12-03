parsers-expressions-basics
mapEnumeration
	^ (lbrace , ((mapletArrow ==> [ :single | Array new ]) / (self maplet separatedBy: comma) withoutSeparators) , rbrace)
		==> #second