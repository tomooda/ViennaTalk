parsers-expressions-basics
undefinedExpression
	^ (self reserved: 'undefined') ==> [ :t | 'ViennaUndefined signal' ]