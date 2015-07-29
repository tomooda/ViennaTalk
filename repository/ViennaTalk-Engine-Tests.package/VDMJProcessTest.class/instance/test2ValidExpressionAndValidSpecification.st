testing-expression and specification
test2ValidExpressionAndValidSpecification
	self
		testExpression: '1+2'
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + 1; return count);'
		states: Dictionary new
		resultValue: '3'
		resultStates: (self stateFromArray: {'DEFAULT' -> {'count' -> '0'}})