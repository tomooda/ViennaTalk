parsers-patterns
seqBind
	^ (pattern , (self reserved: 'in') , (self reserved: 'seq') , expressionExceptEquality)
		==> [ :quatro | 
			{(quatro first).
			(quatro fourth)} ]