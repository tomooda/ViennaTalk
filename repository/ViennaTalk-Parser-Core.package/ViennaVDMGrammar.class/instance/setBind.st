parsers-patterns
setBind
	^ (pattern , (self reserved: 'in') , (self reserved: 'set') , expressionExceptEquality)
		==> [ :quatro | 
			{(quatro first).
			(quatro fourth)} ]