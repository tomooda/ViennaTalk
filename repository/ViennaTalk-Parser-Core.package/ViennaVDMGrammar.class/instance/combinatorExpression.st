parsers-expressions
combinatorExpression
	| precedence2 precedence1 |
	precedence2 := (atomicExpression , ((self operator: '**') , atomicExpression) star)
		==> [ :pair | 
			pair second
				ifEmpty: [ pair first ]
				ifNotEmpty: [ 
					self
						iterateExpression: pair first
						and:
							((pair second size to: 2 by: -1)
								inject: pair second last second
								into: [ :expr :index | self iterateExpression: (pair second at: index - 1) second and: expr ]) ] ].
	precedence1 := (precedence2 , ((self reserved: 'comp') , precedence2) star)
		==> [ :pair | 
			pair second
				ifEmpty: [ pair first ]
				ifNotEmpty: [ 
					self
						compositionExpression: pair first
						and:
							((pair second size to: 2 by: -1)
								inject: pair second last second
								into: [ :expr :index | self compositionExpression: (pair second at: index - 1) second and: expr ]) ] ].
	^ precedence1