parsers-patterns
multipleSeqBind
	^ (patternList , (self reserved: 'in') , (self reserved: 'seq') , expressionExceptEquality)
		==> [ :quatro | 
			{(quatro first).
			(quatro fourth)} ]