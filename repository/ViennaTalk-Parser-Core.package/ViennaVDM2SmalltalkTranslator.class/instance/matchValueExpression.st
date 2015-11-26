parsers-patterns
matchValueExpression
	^ super matchValueExpression
		==> [ :expressionString | 
			{#().
			('(ViennaRuntimeUtil matchValue: ' , expressionString , ')')} ]