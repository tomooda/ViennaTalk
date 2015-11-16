parsers-expressions-type discriminations
isofclassExpression
	^ ((self reserved: 'isofclass') , lparen , name , comma , expression , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]