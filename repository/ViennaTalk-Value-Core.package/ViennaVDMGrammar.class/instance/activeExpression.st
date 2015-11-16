parsers-expressions-threads and histories
activeExpression
	^ ((self reserved: '#active') , lparen , (name separatedBy: comma) withoutSeparators , rparen) ==> #third