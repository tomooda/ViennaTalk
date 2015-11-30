parsers-expressions-basics
undefinedExpression
	^ super undefinedExpression ==> [ :t | 'ViennaUndefinedEvaluationError signal' ]