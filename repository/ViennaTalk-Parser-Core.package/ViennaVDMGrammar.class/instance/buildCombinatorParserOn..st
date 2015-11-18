parsers-expressions
buildCombinatorParserOn: anExpressionParser
	anExpressionParser
		group: [ :iterate | iterate right: (self operator: '**') do: [ :expr1 :op :expr2 | self iterateExpression: expr1 and: expr2 ] ];
		group: [ :comp | comp right: (self reserved: 'comp') do: [ :expr1 :op :expr2 | self compositionExpression: expr1 and: expr2 ] ]