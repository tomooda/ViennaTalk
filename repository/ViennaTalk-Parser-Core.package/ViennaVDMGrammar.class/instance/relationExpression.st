parsers-expressions
relationExpression
	^ (evaluatorExpression
		,
			(((self eqOp , evaluatorExpression)
				==> [ :pair | 
					{#equal:and:.
					(pair second)} ])
				/
					((self notEq , evaluatorExpression)
						==> [ :pair | 
							{#notEqual:and:.
							(pair second)} ])
				/
					((self lessOrEqual , evaluatorExpression)
						==> [ :pair | 
							{#lessEq:and:.
							(pair second)} ])
				/
					((self less , evaluatorExpression)
						==> [ :pair | 
							{#less:and:.
							(pair second)} ])
				/
					((self greaterOrEqual , evaluatorExpression)
						==> [ :pair | 
							{#greaterEq:and:.
							(pair second)} ])
				/
					((self greater , evaluatorExpression)
						==> [ :pair | 
							{#greater:and:.
							(pair second)} ])
				/
					((self subset , evaluatorExpression)
						==> [ :pair | 
							{#subset:and:.
							(pair second)} ])
				/
					((self psubset , evaluatorExpression)
						==> [ :pair | 
							{#psubset:and:.
							(pair second)} ])
				/
					((self inset ==> [ :op |  ] , evaluatorExpression)
						==> [ :pair | 
							{#inSet:and:.
							(pair second)} ])
				/
					(((self notOp , (self reserved: 'in') , (self reserved: 'set')) ==> [ :op |  ] , evaluatorExpression)
						==> [ :pair | 
							{#notInSet:and:.
							(pair second)} ])) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ]