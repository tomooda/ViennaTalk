parsers-expressions
setRangeExpression
	^ ((self operator: ${) , expression , (self operator: $,) , (self operator: '...') , (self operator: $,) , expression
		, (self operator: $}))
		==> [ :array | 
			{(array second).
			(array sixth)} ]