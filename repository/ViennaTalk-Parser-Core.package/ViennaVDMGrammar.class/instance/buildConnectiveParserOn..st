parsers-expressions
buildConnectiveParserOn: anExpressionParser
	anExpressionParser
		group: [ :p5 | p5 prefix: (self reserved: 'not') do: [ :op :arg | self not: arg ] ];
		group: [ :p4 | p4 left: (self reserved: 'and') do: [ :arg1 :op :arg2 | self and: arg1 and: arg2 ] ];
		group: [ :p3 | p3 left: (self reserved: 'or') do: [ :arg1 :op :arg2 | self or: arg1 and: arg2 ] ];
		group: [ :p2 | p2 right: (self operator: '=>') do: [ :arg1 :op :arg2 | self imp: arg1 and: arg2 ] ];
		group: [ :p1 | p1 left: (self operator: '<=>') do: [ :arg1 :op :arg2 | self equiv: arg1 and: arg2 ] ]