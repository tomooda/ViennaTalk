parsers-expressions
atomicExpression
	^ self letExpression / self letBeExpression / self defExpression / self ifExpression / self casesExpression
		/ self quantifiedExpression / self iotaExpression / self mapEnumeration / self mapComprehension / self setEnumeration
		/ self setComprehension / self setRangeExpression / self sequenceEnumeration / self sequenceComprehension
		/ self tupleConstructor / self recordConstructor / self tokenConstructor / self recordModifier / self lambdaExpression
		/ self resultExpression / self narrowExpression / self newExpression / self selfExpression / self threadidExpression
		/ self generalIsExpr / self undefinedExpression / self preconditionExpression / self isofbaseclassExpression
		/ self isofclassExpression / self samebaseclassExpression / self sameclassExpression / self actExpression
		/ self finExpression / self activeExpression / self reqExpression / self waitingExpression / self timeExpression
		/ name / self oldName / symbolicLiteral / ((lparen , expression , rparen) ==> [ :triple | triple second ])