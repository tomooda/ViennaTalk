parsers-expressions
expression
	^ letExpression / letBeExpression / defExpression / ifExpression / casesExpression / unaryExpression / binaryExpression
		/ quantifiedExpression / iotaExpression / setEnumeration / setComprehension / setRangeExpression / sequenceEnumeration
		/ sequenceComprehension / subsequence / mapEnumeration / mapComprehension / tupleConstructor / recordConstructor
		/ recordModifier / apply / fieldSelect / tupleSelect / functionTypeInstantiation / lambdaExpression / newExpression
		/ selfExpression / threadidExpression / generalIsExpr / undefinedExpression / preconditionExpression
		/ isofbaseclassExpression / isofclassExpression / samebaseclassExpression / sameclassExpression / actExpression
		/ finExpression / activeExpression / reqExpression / waitingExpression / timeExpression / name / oldName
		/ symbolicLiteral / (($( asParser trim , expression , $) asParser trim) ==> [ :triple | triple second ])