parsers-expressions-basics
tokenConstructor
	^ ((self reserved: 'mk_token' asParser) , lparen , expression , rparen) ==> #third