testing-expression and state
test2ValidExpressionAndInvalidState
	self
		testExpression: '1+2'
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> 'frq'}})
		resultValue: '3'
		resultStates: Dictionary new