testing-all
test3ValidExpressionAndInvalidSpecificationAndInvalidState
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '4+"41"'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '4+"41"'}}).
	self
		testExpression: ' inc ( ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '4+"41"'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '4+"41"'}})