parsers-expressions
expressionExceptEquality
	| expressionParser |
	expressionParser := PPExpressionParser new.
	expressionParser
		term:
			letExpression / letBeExpression / defExpression / ifExpression / casesExpression / quantifiedExpression / iotaExpression
				/ setEnumeration / setComprehension / setRangeExpression / sequenceEnumeration / sequenceComprehension
				/ mapEnumeration / mapComprehension / tupleConstructor / recordConstructor / recordModifier / lambdaExpression
				/ newExpression / selfExpression / threadidExpression / generalIsExpr / undefinedExpression / preconditionExpression
				/ isofbaseclassExpression / isofclassExpression / samebaseclassExpression / sameclassExpression / actExpression
				/ finExpression / activeExpression / reqExpression / waitingExpression / timeExpression / name / oldName
				/ symbolicLiteral / (((self operator: $() , expression , (self operator: $))) ==> [ :triple | triple second ]).
	self buildCombinatorParserOn: expressionParser.
	self buildApplicatorParserOn: expressionParser.
	self buildEvaluatorParserOn: expressionParser.
	self buildRelationParserExceptEqualityOn: expressionParser.
	self buildConnectiveParserOn: expressionParser.
	^ expressionParser