parsers-expressions
evaluatorExpression
	| precedence6 precedence5 precedence4 precedence3 precedence2 precedence1 |
	precedence6 := ((((self operator: $+) ==> [ :plus | 'unaryPlus' ])
		/ ((self operator: $-) ==> [ :minus | 'unaryMinus' ]) / (self reserved: 'abs') / (self reserved: 'floor')
		/ (self reserved: 'card') / (self reserved: 'power') / (self reserved: 'dinter') / (self reserved: 'dunion')
		/ (self reserved: 'dom') / (self reserved: 'rng') / (self reserved: 'merge') / (self reserved: 'len')
		/ (self reserved: 'elems') / (self reserved: 'hd') / (self reserved: 'tl') / (self reserved: 'conc')
		/ (self reserved: 'inds') / (self reserved: 'reverse')) star , applicatorExpression)
		==> [ :pair | pair first reverse inject: pair second into: [ :expr :sel | self perform: (sel , ':') asSymbol with: expr ] ].
	precedence5 := (precedence6
		,
			(((self operator: ':>') ==> [ :op | #map:rangeRestrictedTo: ])
				/ ((self operator: ':->') ==> [ :op | #map:rangeRestrictedBy: ]) , precedence6) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	precedence4 := (precedence5
		,
			(((self operator: '<:') ==> [ :op | #map:domainRestrictedTo: ])
				/ ((self operator: '<-:') ==> [ :op | #map:domainRestrictedBy: ]) , precedence5) star)
		==> [ :pair | 
			pair second
				ifEmpty: [ pair first ]
				ifNotEmpty: [ 
					self
						perform: pair second first first
						with: pair first
						with:
							((pair second size to: 2 by: -1)
								inject: pair second last second
								into: [ :expr :index | self perform: (pair second at: index) first with: (pair second at: index - 1) second with: expr ]) ] ].
	precedence3 := ((self reserved: 'inverse') star , precedence4)
		==> [ :pair | pair first inject: pair second into: [ :expr :inv | self inverse: expr ] ].
	precedence2 := (precedence3
		,
			((((self operator: $*) , precedence3)
				==> [ :pair | 
					{#mul:and:.
					(pair second)} ])
				/
					(((self operator: $/) , precedence3)
						==> [ :pair | 
							{#fraction:and:.
							(pair second)} ])
				/
					(((self reserved: 'rem') , precedence3)
						==> [ :pair | 
							{#rem:and:.
							(pair second)} ])
				/
					(((self reserved: 'mod') , precedence3)
						==> [ :pair | 
							{#mod:and:.
							(pair second)} ])
				/
					(((self reserved: 'div') , precedence3)
						==> [ :pair | 
							{#div:and:.
							(pair second)} ])
				/
					(((self reserved: 'inter') , precedence3)
						==> [ :pair | 
							{#inter:and:.
							(pair second)} ])) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	precedence1 := (precedence2
		,
			(((($+ asParser , $+ asParser not) trim , precedence2)
				==> [ :pair | 
					{#plus:and:.
					(pair second)} ])
				/
					(((self operator: $-) , precedence2)
						==> [ :pair | 
							{#minus:and:.
							(pair second)} ])
				/
					(((self reserved: 'union') , precedence2)
						==> [ :pair | 
							{#union:and:.
							(pair second)} ])
				/
					(((self operator: $\) , precedence2)
						==> [ :pair | 
							{#diff:and:.
							(pair second)} ])
				/
					(((self reserved: 'munion') , precedence2)
						==> [ :pair | 
							{#munion:and:.
							(pair second)} ])
				/
					(((self operator: '++') , precedence2)
						==> [ :pair | 
							{#mconcat:and:.
							(pair second)} ])
				/
					(((self operator: $^) , precedence2)
						==> [ :pair | 
							{#concat:and:.
							(pair second)} ])) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	^ precedence1