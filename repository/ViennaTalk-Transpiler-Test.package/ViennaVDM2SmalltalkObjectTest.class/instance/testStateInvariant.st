tests-invariants
testStateInvariant
	| obj |
	obj := self
		transpile:
			'
	state State of 
		count : int
		inv mk_State(c) == c >= 0
		init s == s = mk_State(10) 
	end
	operations 
	sub : int ==> int 
	sub(x) == (count := count - x; return count)
	post count >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'sub(9)') equals: 1.
	self should: [ obj evaluateExpression: 'sub(9)' ] raise: ViennaStateInvariantViolation