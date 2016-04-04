parsers-expressions
evaluatorExpression
	| precedence6 precedence5 precedence4 precedence3 precedence2 precedence1 |
	precedence6 := ((((self operator: $+) ==> [ :plus | 'unaryPlus' ])
		/ ((self operator: $-) ==> [ :minus | 'unaryMinus' ]) / self abs / self floor / self card / self power / self dinter
		/ self dunion / self dom / self rng / self merge / self len / self elems / self hd / self tl / self conc / self inds
		/ self reverse) star , self applicatorExpression)
		==> [ :pair | pair first reverse inject: pair second into: [ :expr :sel | self perform: (sel , ':') asSymbol with: expr ] ].
	precedence5 := (precedence6
		,
			((self mapRangeRestrictedTo ==> [ :op | #map:rangeRestrictedTo: ])
				/ (self mapRangeRestrictedBy ==> [ :op | #map:rangeRestrictedBy: ]) , precedence6) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	precedence4 := (precedence5
		,
			((self mapDomainRestrictedTo ==> [ :op | #map:domainRestrictedTo: ])
				/ (self mapDomainRestrictedBy ==> [ :op | #map:domainRestrictedBy: ]) , precedence5) star)
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
	precedence3 := (self inverse star , precedence4)
		==> [ :pair | pair first inject: pair second into: [ :expr :inv | self inverse: expr ] ].
	precedence2 := (precedence3
		,
			(((self starOp , precedence3)
				==> [ :pair | 
					{#mul:and:.
					(pair second)} ])
				/
					((self slash , precedence3)
						==> [ :pair | 
							{#fraction:and:.
							(pair second)} ])
				/
					((self rem , precedence3)
						==> [ :pair | 
							{#rem:and:.
							(pair second)} ])
				/
					((self mod , precedence3)
						==> [ :pair | 
							{#mod:and:.
							(pair second)} ])
				/
					((self div , precedence3)
						==> [ :pair | 
							{#div:and:.
							(pair second)} ])
				/
					((self inter , precedence3)
						==> [ :pair | 
							{#inter:and:.
							(pair second)} ])) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	precedence1 := (precedence2
		,
			(((self plusOp , precedence2)
				==> [ :pair | 
					{#plus:and:.
					(pair second)} ])
				/
					((self minusOp , precedence2)
						==> [ :pair | 
							{#minus:and:.
							(pair second)} ])
				/
					((self union , precedence2)
						==> [ :pair | 
							{#union:and:.
							(pair second)} ])
				/
					((self diffOp , precedence2)
						==> [ :pair | 
							{#diff:and:.
							(pair second)} ])
				/
					((self munion , precedence2)
						==> [ :pair | 
							{#munion:and:.
							(pair second)} ])
				/
					((self plusPlusOp , precedence2)
						==> [ :pair | 
							{#mconcat:and:.
							(pair second)} ])
				/
					((self hatOp , precedence2)
						==> [ :pair | 
							{#concat:and:.
							(pair second)} ])) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	^ precedence1