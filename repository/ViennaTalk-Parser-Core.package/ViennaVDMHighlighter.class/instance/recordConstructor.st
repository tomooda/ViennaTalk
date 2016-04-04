parsers-expressions
recordConstructor
	^ ('mk_' asParser , (self type: name) , lparen , expressionList , rparen)
		==> [ :array | 
			{(array second).
			(array fourth)} ]