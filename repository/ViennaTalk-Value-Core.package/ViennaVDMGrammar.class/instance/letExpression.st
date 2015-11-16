parsers-expressions-basics
letExpression
	| localDefinition |
	localDefinition := valueDefinition / functionDefinition.
	^ ((self reserved: 'let') , (localDefinition separatedBy: comma) withoutSeparators , (self reserved: 'in') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]