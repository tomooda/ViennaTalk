tests
testEval2
	vdmc specification: 'values one = 1;'.
	self assert: (vdmc evaluate: 'one + 2') equals: 3.