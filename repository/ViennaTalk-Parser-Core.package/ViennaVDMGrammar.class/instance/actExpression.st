parsers-expressions-threads and histories
actExpression
	^ ((self reserved: '#act') , lparen , (name separatedBy: comma) withoutSeparators , rparen) ==> #third