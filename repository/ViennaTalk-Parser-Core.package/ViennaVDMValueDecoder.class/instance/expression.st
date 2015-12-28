parsers-expressions
expression
	^ self mapEnumeration / self setEnumeration / self sequenceEnumeration / self tupleConstructor / self recordConstructor
		/ self tokenConstructor / self undefinedExpression / symbolicLiteral
		/ ((lparen , expression , rparen) ==> [ :triple | triple second ])