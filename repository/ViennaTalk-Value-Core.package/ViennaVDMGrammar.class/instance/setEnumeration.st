parsers-expressions
setEnumeration
	^ ((self operator: ${)
		, ((expression separatedBy: (self operator: $,)) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ])
		, (self operator: $})) ==> #second