testing-expression and state
test2InvalidExpressionAndInvalidState
	self
		testExpression: '1+'
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> 'frq'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> 'frq'}})