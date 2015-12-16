parsers-expressions-basics
ifExpression
	^ super ifExpression
		==> [ :array | 
			ViennaNode
				label: 'IfExpression'
				with:
					(ViennaNode
						label: 'ConditionaExpressionList'
						withAll: (array first collect: [ :pair | ViennaNode label: 'ConditionalExpression' withAll: pair ]))
				with: array second ]