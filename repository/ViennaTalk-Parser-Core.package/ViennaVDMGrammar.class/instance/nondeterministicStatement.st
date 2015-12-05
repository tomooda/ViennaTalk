parsers-statements
nondeterministicStatement
	^ ((self operator: '||') , lparen , (statement separatedBy: comma) withoutSeparators , rparen) ==> #third