parsers-expressions-basics
letExpression
	^ ((self reserved: 'let') , self localDefinitionList, (self reserved: 'in')
		, expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]