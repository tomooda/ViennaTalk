parsers-expressions-type discriminations
isofbaseclassExpression
	^ ((self reserved: 'isofbaseclass') , lparen , name , comma , expression , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]