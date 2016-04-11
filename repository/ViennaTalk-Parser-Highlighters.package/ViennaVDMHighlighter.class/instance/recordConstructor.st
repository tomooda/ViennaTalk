parsers-expressions
recordConstructor
	^ ('mk_' asParser , self typeName , lparen , expressionList , rparen)
		==> [ :array | 
			{(array second).
			(array fourth)} ]