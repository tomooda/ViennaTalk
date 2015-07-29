testing-only states
test1InvalidStates
	self
		testExpression: ''
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '441frq'}})
		resultValue: ''
		resultStates: Dictionary new.
	self
		testExpression: ''
		specification: ''
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '4+"41"'}})
		resultValue: ''
		resultStates: Dictionary new