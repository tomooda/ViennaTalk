parsers-statements
ifStatement
	^ super ifStatement
		=>> [ :start :end :array | 
			ViennaNode
				label: 'IfStatement'
				start: start
				end: end
				with:
					(ViennaNode
						label: 'ConditionaStatementList'
						withAll: (array first collect: [ :pair | ViennaNode label: 'ConditionalStatement' withAll: pair ]))
				with: array second ]