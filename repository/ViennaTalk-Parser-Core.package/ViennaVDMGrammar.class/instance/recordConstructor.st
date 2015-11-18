parsers-expressions-basics
recordConstructor
	^ ('mk_' asParser , name , lparen
		, ((expression separatedBy: comma) withoutSeparators optional ==> [ :args | args ifNil: [ Array new ] ]) , rparen)
		==> [ :array | 
			{(array second).
			(array fourth)} ]