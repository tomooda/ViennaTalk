tests-type checking
testOperationTypecheck
	| obj |
	obj := self
		transpile:
			'
	state State of 
		count : int
		init s == s = mk_State(10) 
	end
	operations 
	sub : nat ==> nat 
	sub(x) == (count := count - x; return count)
	post count >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'sub(9)') equals: 1.
	self should: [ obj evaluateExpression: 'sub(-9)' ] raise: ViennaRuntimeTypeError.
	self should: [ obj evaluateExpression: 'sub(9)' ] raise: ViennaRuntimeTypeError