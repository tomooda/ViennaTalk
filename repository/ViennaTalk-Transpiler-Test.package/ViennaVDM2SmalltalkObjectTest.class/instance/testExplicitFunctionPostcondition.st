tests-postconditions
testExplicitFunctionPostcondition
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred : int -> int 
	pred(x) == x - 1
	post RESULT >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'pred(10)') equals: 9.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaPostconditionViolation