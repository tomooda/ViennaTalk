testing-all
test3InvalidExpressionAndValidSpecificationAndValidState
	self
		testExpression: ' inc ( 3 ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'frq' -> '0'}}).
	self
		testExpression: ' inc ( 3 ) '
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})
		resultValue: nil
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '441'}})