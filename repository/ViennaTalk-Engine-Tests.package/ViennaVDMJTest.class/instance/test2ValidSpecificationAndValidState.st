testing-specification and state
test2ValidSpecificationAndValidState
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: ''
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}}).
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: ''
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})