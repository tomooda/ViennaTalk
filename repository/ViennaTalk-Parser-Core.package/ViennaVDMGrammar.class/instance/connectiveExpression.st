parsers-expressions
connectiveExpression
	| precedence5 precedence4 precedence3 precedence2 precedence1 |
	precedence5 := ((self reserved: 'not') star , relationExpression)
		==> [ :pair | pair first inject: pair second into: [ :expr :op | self not: expr ] ].
	precedence4 := (precedence5 , ((self reserved: 'and') , precedence5) star)
		==> [ :pair | pair second inject: pair first into: [ :expr :and | self and: expr and: and second ] ].
	precedence3 := (precedence4 , ((self reserved: 'or') , precedence4) star)
		==> [ :pair | pair second inject: pair first into: [ :expr :or | self or: expr and: or second ] ].
	precedence2 := (precedence3 , ((self operator: '=>') , precedence3) star)
		==> [ :pair | 
			pair second
				ifEmpty: [ pair first ]
				ifNotEmpty: [ 
					self
						imp: pair first
						and:
							((pair second size to: 2 by: -1)
								inject: pair second last second
								into: [ :expr :index | self imp: (pair second at: index - 1) second and: expr ]) ] ].
	precedence1 := (precedence2 , ((self operator: '<=>') , precedence2) star)
		==> [ :pair | pair second inject: pair first into: [ :expr :bool | self equiv: expr and: bool second ] ].
	^ precedence1