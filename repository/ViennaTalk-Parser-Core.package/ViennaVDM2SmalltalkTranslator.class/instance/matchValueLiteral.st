parsers-patterns
matchValueLiteral
	^ super matchValueLiteral
		==> [ :literal | 
			{#().
			('(ViennaRuntimeUtil matchValue: ' , literal , ')')} ]