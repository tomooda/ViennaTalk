tests-type checking
testFunctionTypecheck
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred : nat -> nat 
	pred(x) == x - 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'pred(9)') equals: 8.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaRuntimeTypeError.
	self should: [ obj evaluateExpression: 'pred(-1)' ] raise: ViennaRuntimeTypeError