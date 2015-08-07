testing-only specification
test1ValidSpecification
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: Dictionary new
		resultValue: ''
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})