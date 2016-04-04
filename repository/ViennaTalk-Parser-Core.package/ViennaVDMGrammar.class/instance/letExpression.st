parsers-expressions-basics
letExpression
	^ (self let , self localDefinitionList , self in , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]