parsers-expressions-basics
recordConstructor
	^ ('mk_' asParser , name , lparen , expressionList , rparen)
		==> [ :array | 
			{(array second).
			(array fourth)} ]