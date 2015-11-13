parsers-expressions
letExpression
	| localDefinition |
	localDefinition := valueDefinition / functionDefinition.
	^ ((self reserved: 'let') , (localDefinition separatedBy: (self operator: $,)) withoutSeparators
		, (self reserved: 'in') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]