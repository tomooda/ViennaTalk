tests
testEval2
	animation specification: 'values one = 1;'.
	self assert: (animation evaluate: 'one + 2') equals: 3.