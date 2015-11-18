parsers-expressions-basics
setEnumeration
	^ (lbrace , ((expression separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ])
		, rbrace) ==> #second