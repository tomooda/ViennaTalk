parsers-expressions
buildEvaluatorParserOn: anExpressionParser
	anExpressionParser
		group: [ :p6 | 
					p6
						prefix: (self operator: $+) do: [ :op :arg | self unaryPlus: arg ];
						prefix: (self operator: $-) do: [ :op :arg | self unaryMinus: arg ].
					#('abs' 'floor' 'card' 'power' 'dinter' 'dunion' 'dom' 'rng' 'merge' 'len' 'elems' 'hd' 'tl' 'conc' 'inds')
						do: [ :operator | p6 prefix: (self reserved: operator) do: [ :op :arg | self perform: (op , ':') asSymbol with: arg ] ] ];
		group: [ :p5 | 
					p5 left: (self operator: ':>') do: [ :arg1 :op :arg2 | self map: arg1 rangeRestrictedTo: arg2 ].
					p5 left: (self operator: ':->') do: [ :arg1 :op :arg2 | self map: arg1 rangeRestrictedBy: arg2 ] ];
		group: [ :p4 | 
					p4 right: (self operator: '<:') do: [ :arg1 :op :arg2 | self map: arg1 domainRestrictedTo: arg2 ].
					p4 right: (self operator: '<-:') do: [ :arg1 :op :arg2 | self map: arg1 domainRestrictedBy: arg2 ] ];
		group: [ :p3 | p3 prefix: (self reserved: 'inverse') do: [ :op :arg | self inverse: arg ] ];
		group: [ :p2 | 
					p2
						left: (self operator: $*) do: [ :arg1 :op :arg2 | self mul: arg1 and: arg2 ];
						left: (self operator: $/) do: [ :arg1 :op :arg2 | self fraction: arg1 and: arg2 ];
						left: (self reserved: 'rem') do: [ :arg1 :op :arg2 | self rem: arg1 and: arg2 ];
						left: (self reserved: 'mod') do: [ :arg1 :op :arg2 | self mod: arg1 and: arg2 ];
						left: (self reserved: 'div') do: [ :arg1 :op :arg2 | self div: arg1 and: arg2 ];
						left: (self reserved: 'inter') do: [ :arg1 :op :arg2 | self inter: arg1 and: arg2 ] ];
		group: [ :p1 | 
					p1
						left: (self operator: $+) do: [ :arg1 :op :arg2 | self plus: arg1 and: arg2 ];
						left: (self operator: $-) do: [ :arg1 :op :arg2 | self minus: arg1 and: arg2 ];
						left: (self reserved: 'union') do: [ :arg1 :op :arg2 | self union: arg1 and: arg2 ];
						left: (self operator: $\) do: [ :arg1 :op :arg2 | self diff: arg1 and: arg2 ];
						left: (self reserved: 'munion') do: [ :arg1 :op :arg2 | self munion: arg1 and: arg2 ];
						left: (self operator: '++') do: [ :arg1 :op :arg2 | self mconcat: arg1 and: arg2 ];
						left: (self operator: '^') do: [ :arg1 :op :arg2 | self concat: arg1 and: arg2 ] ]