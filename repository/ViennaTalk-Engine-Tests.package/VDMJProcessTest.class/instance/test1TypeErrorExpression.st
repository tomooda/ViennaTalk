testing-only expression
test1TypeErrorExpression
	self
		testExpression: ' 1 +  "2"'
		specification: ''
		states: Dictionary new
		resultValue: nil
		resultStates: Dictionary new