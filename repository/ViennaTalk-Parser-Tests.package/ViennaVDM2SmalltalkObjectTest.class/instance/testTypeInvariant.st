tests-invariants
testTypeInvariant
	| obj |
	obj := self
		transpile:
			'
	types
		N0 = int inv n == n >= 0
	state State of 
		count : N0
		init s == s = mk_State(10) 
	end
	operations 
	sub : int ==> int 
	sub(x) == (count := count - x; return count);'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'sub(9)') equals: 1.
	self should: [ obj evaluateExpression: 'sub(9)' ] raise: ViennaRuntimeTypeError.
	self assert: (obj evaluateExpression: 'is_N0(1)') equals: true.
	self assert: (obj evaluateExpression: 'is_N0(-1)') equals: false