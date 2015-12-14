parsers-expressions-basics
defExpression
	^ super defExpression
		==> [ :array | 
			ViennaNode
				label: 'DefExpression'
				with: (ViennaNode label: 'EqualDefinitionList' withAll: array first)
				with: array second ]