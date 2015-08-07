testing-only specification
test1InvalidSpecification
	self
		testExpression: ''
		specification: 'state counter of count : nat init s == s = mk_counter(0) end operations inc : () ==> nat inc() == (count := count + "1"; return count);'
		states: Dictionary new
		resultValue: nil
		resultStates: (Dictionary new)