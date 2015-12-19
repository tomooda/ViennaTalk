parsers-expressions
expression
	| expressionParser |
	expressionParser := PPExpressionParser new.
	expressionParser
		term:
			mapEnumeration / setEnumeration / sequenceEnumeration / tupleConstructor / recordConstructor / undefinedExpression
				/ symbolicLiteral / ((lparen , expression , rparen) ==> [ :triple | triple second ]).
	^ expressionParser