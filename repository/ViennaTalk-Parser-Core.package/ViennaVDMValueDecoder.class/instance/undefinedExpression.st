parsers-expressions
undefinedExpression
	^ super undefinedExpression ==> [ :t | ViennaUndefinedEvaluationError signal ]