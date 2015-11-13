parsers-expressions
expression
	| expressionParser |
	expressionParser := PPExpressionParser new.
	expressionParser
		term:
			letExpression / letBeExpression / defExpression / ifExpression / casesExpression / quantifiedExpression / iotaExpression
				/ setEnumeration / setComprehension / setRangeExpression / sequenceEnumeration / sequenceComprehension
				/ mapEnumeration / mapComprehension / tupleConstructor / recordConstructor / recordModifier / tupleSelect
				/ lambdaExpression / newExpression / selfExpression / threadidExpression / generalIsExpr / undefinedExpression
				/ preconditionExpression / isofbaseclassExpression / isofclassExpression / samebaseclassExpression
				/ sameclassExpression / actExpression / finExpression / activeExpression / reqExpression / waitingExpression
				/ timeExpression / name / oldName / symbolicLiteral
				/ (((self operator: $() , expression , (self operator: $))) ==> [ :triple | triple second ]).
	self buildCombinatorParserOn: expressionParser.
	self buildApplicatorParserOn: expressionParser.
	self buildEvaluatorParserOn: expressionParser.
	self buildRelationParserOn: expressionParser.
	self buildConnectiveParserOn: expressionParser.
	^ expressionParser