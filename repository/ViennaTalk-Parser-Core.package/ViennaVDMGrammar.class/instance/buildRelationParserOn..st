parsers-expressions
buildRelationParserOn: anExpressionParser
	anExpressionParser
		group: [ :p1 | 
			p1
				left: (self operator: $=) do: [ :arg1 :op :arg2 | self equal: arg1 and: arg2 ];
				left: (self operator: '<>') do: [ :arg1 :op :arg2 | self notEqual: arg1 and: arg2 ];
				left: (self operator: '<=') do: [ :arg1 :op :arg2 | self lessEq: arg1 and: arg2 ];
				left: (self operator: $< asParser , $= asParser not) do: [ :arg1 :op :arg2 | self less: arg1 and: arg2 ];
				left: (self operator: '>=') do: [ :arg1 :op :arg2 | self greaterEq: arg1 and: arg2 ];
				left: (self operator: $> asParser , $= asParser not) do: [ :arg1 :op :arg2 | self greater: arg1 and: arg2 ];
				left: (self reserved: 'subset') do: [ :arg1 :op :arg2 | self subset: arg1 and: arg2 ];
				left: (self reserved: 'psubset') do: [ :arg1 :op :arg2 | self psubset: arg1 and: arg2 ];
				left: (self reserved: 'in') , (self reserved: 'set') do: [ :arg1 :op :arg2 | self inSet: arg1 and: arg2 ];
				left: (self reserved: 'not') , (self reserved: 'in') , (self reserved: 'set')
					do: [ :arg1 :op :arg2 | self notInSet: arg1 and: arg2 ] ]