parsers-expressions-basics
sequenceEnumeration
	^ (lbracket , ((expression separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ])
		, rbracket) ==> #second