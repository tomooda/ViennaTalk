parsers-patterns
multipleSetBind
	^ (patternList , (self reserved: 'in') , (self reserved: 'set') , expressionExceptEquality)
		==> [ :quatro | 
			{(quatro first).
			(quatro fourth)} ]