parsers-expressions-threads and histories
finExpression
	^ ((self reserved: '#fin') , lparen , (name separatedBy: comma) withoutSeparators , rparen) ==> #third