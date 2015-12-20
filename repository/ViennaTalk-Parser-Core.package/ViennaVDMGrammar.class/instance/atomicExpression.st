parsers-expressions
atomicExpression
	^ letExpression / letBeExpression / defExpression / ifExpression / casesExpression / quantifiedExpression
		/ iotaExpression / mapEnumeration / mapComprehension / setEnumeration / setComprehension / setRangeExpression
		/ sequenceEnumeration / sequenceComprehension / tupleConstructor / recordConstructor / recordModifier
		/ lambdaExpression / narrowExpression / newExpression / selfExpression / threadidExpression / generalIsExpr
		/ undefinedExpression / preconditionExpression / isofbaseclassExpression / isofclassExpression
		/ samebaseclassExpression / sameclassExpression / actExpression / finExpression / activeExpression / reqExpression
		/ waitingExpression / timeExpression / name / oldName / symbolicLiteral
		/ ((lparen , expression , rparen) ==> [ :triple | triple second ])