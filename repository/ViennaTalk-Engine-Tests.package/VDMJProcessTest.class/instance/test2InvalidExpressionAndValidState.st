testing-expression and state
test2InvalidExpressionAndValidState
	self
		testExpression: '1+'
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})