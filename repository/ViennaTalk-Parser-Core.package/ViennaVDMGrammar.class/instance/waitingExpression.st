parsers-expressions-threads and histories
waitingExpression
	^ ((self reserved: '#waiting') , lparen , (name separatedBy: comma) withoutSeparators , rparen) ==> #third