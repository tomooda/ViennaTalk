testing-all
test3ValidExpressionAndValidSpecificationAndValidState
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: '1'
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '1'}}).
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: '442'
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '442'}})