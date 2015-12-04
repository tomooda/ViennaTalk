parsers-expressions-basics
letExpression
	^ ((self reserved: 'let') , (self localDefinition separatedBy: comma) withoutSeparators , (self reserved: 'in')
		, expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]