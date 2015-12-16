parsers-statements
ifStatement
	^ super ifStatement
		==> [ :array | 
			ViennaNode
				label: 'IfStatement'
				with:
					(ViennaNode
						label: 'ConditionaStatementList'
						withAll: (array first collect: [ :pair | ViennaNode label: 'ConditionalStatement' withAll: pair ]))
				with: array second ]