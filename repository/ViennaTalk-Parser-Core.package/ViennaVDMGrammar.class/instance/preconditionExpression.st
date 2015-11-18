parsers-expressions-basics
preconditionExpression
	^ ((self reserved: 'pre_') , lparen , (expression separatedBy: comma) withoutSeparators , rparen) ==> #third