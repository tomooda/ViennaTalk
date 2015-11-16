parsers-expressions-basics
expression
	| expressionParser |
	expressionParser := PPExpressionParser new.
	expressionParser
		term:
			letExpression / letBeExpression / defExpression / ifExpression / casesExpression / quantifiedExpression / iotaExpression
				/ mapEnumeration / mapComprehension / setEnumeration / setComprehension / setRangeExpression / sequenceEnumeration
				/ sequenceComprehension / tupleConstructor / recordConstructor / recordModifier / lambdaExpression
				/ narrowExpression / newExpression / selfExpression / threadidExpression / generalIsExpr / undefinedExpression
				/ preconditionExpression / isofbaseclassExpression / isofclassExpression / samebaseclassExpression
				/ sameclassExpression / actExpression / finExpression / activeExpression / reqExpression / waitingExpression
				/ timeExpression / name / oldName / symbolicLiteral
				/ ((lparen , expression , rparen) ==> [ :triple | triple second ]).
	self buildCombinatorParserOn: expressionParser.
	self buildApplicatorParserOn: expressionParser.
	self buildEvaluatorParserOn: expressionParser.
	self buildRelationParserOn: expressionParser.
	self buildConnectiveParserOn: expressionParser.
	^ expressionParser