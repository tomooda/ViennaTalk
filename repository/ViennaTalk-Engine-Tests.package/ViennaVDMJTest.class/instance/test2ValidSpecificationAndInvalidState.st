testing-specification and state
test2ValidSpecificationAndInvalidState
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> 'frq'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> 'frq'}}).
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '441'}})
		resultValue: ''
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})