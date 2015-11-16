parsers-expressions-basics
newExpression
	^ ((self reserved: 'new') , name , lparen
		, ((expression separatedBy: comma) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ]) , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]