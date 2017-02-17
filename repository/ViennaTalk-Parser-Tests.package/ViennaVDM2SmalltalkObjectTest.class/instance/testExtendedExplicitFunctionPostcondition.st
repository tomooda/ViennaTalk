tests-postconditions
testExtendedExplicitFunctionPostcondition
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred(x:int) res:int == x - 1
	post res >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'pred(10)') equals: 9.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaPostconditionViolation