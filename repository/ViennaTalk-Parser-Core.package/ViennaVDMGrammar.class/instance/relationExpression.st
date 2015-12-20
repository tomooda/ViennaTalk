parsers-expressions
relationExpression
	^ (evaluatorExpression
		,
			((((self operator: '=') , evaluatorExpression)
				==> [ :pair | 
					{#equal:and:.
					(pair second)} ])
				/
					(((self operator: '<>') , evaluatorExpression)
						==> [ :pair | 
							{#notEqual:and:.
							(pair second)} ])
				/
					(((self operator: '<=') , evaluatorExpression)
						==> [ :pair | 
							{#lessEq:and:.
							(pair second)} ])
				/
					(((self operator: '<') , evaluatorExpression)
						==> [ :pair | 
							{#less:and:.
							(pair second)} ])
				/
					(((self operator: '>=') , evaluatorExpression)
						==> [ :pair | 
							{#greaterEq:and:.
							(pair second)} ])
				/
					(((self operator: '>') , evaluatorExpression)
						==> [ :pair | 
							{#greater:and:.
							(pair second)} ])
				/
					(((self reserved: 'subset') , evaluatorExpression)
						==> [ :pair | 
							{#subset:and:.
							(pair second)} ])
				/
					(((self reserved: 'psubset') , evaluatorExpression)
						==> [ :pair | 
							{#psubset:and:.
							(pair second)} ])
				/
					((((self reserved: 'in') , (self reserved: 'set')) ==> [ :op |  ] , evaluatorExpression)
						==> [ :pair | 
							{#inSet:and:.
							(pair second)} ])
				/
					((((self reserved: 'not') , (self reserved: 'in') , (self reserved: 'set')) ==> [ :op |  ] , evaluatorExpression)
						==> [ :pair | 
							{#notInSet:and:.
							(pair second)} ])) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ]