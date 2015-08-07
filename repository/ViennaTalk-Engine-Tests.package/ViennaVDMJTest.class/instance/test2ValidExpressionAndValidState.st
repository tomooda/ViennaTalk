testing-expression and state
test2ValidExpressionAndValidState
	self
		testExpression: '1+2'
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})
		resultValue: '3'
		resultStates: Dictionary new