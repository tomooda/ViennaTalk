tests-postconditions
testImplilcitFunctionPostcondition
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred(x:int) res:int
	post res - x = 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'post_pred(10, 11)') equals: true.
	self assert: (obj evaluateExpression: 'post_pred(10, 9)') equals: false.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaImplicitEvaluationError