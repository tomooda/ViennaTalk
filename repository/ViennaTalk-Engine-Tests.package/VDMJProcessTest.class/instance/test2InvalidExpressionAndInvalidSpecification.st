testing-expression and specification
test2InvalidExpressionAndInvalidSpecification
	self
		testExpression: '1+'
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := frq + 1; return count);'
		states: Dictionary new
		resultValue: nil
		resultStates: Dictionary new