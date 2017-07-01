tests-postconditions
testImplilcitOperationPostcondition
	| obj |
	obj := self
		transpile:
			'
	operations 
	pred(x:int) res:int
	pre x > 0
	post res - x = 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'post_pred(10, nil, nil, 11)') equals: true.
	self assert: (obj evaluateExpression: 'post_pred(10, nil, nil, 9)') equals: false.
	self should: [ obj evaluateExpression: 'pred(10)' ] raise: ViennaImplicitEvaluationError.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaPreconditionViolation