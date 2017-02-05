tests
testReal
	self assert: 1.0 viennaString equals: '1.0'.
	self assert: -1.0 viennaString equals: '-1.0'.
	self assert: -1.0e-16 viennaString equals: '-1.0e-16'