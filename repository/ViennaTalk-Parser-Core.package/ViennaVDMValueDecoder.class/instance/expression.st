parsers-expressions
expression
	| expressionParser |
	expressionParser := PPExpressionParser new.
	expressionParser
		term:
			self mapEnumeration / self setEnumeration / self sequenceEnumeration / self tupleConstructor / self recordConstructor
				/ self undefinedExpression / symbolicLiteral / ((lparen , expression , rparen) ==> [ :triple | triple second ]).
	^ expressionParser