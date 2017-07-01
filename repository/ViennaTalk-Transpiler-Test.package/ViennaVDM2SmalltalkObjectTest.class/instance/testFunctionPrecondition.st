tests-preconditions
testFunctionPrecondition
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred : int -> int 
	pred(x) == x - 1
	pre x > 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'pred(9)') equals: 8.
	self should: [ obj evaluateExpression: 'pred(-1)' ] raise: ViennaPreconditionViolation