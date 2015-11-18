tests-types
testFieldSelect1
	self assert: (grammar expression end parse: 'r1.f1') equals: #('r1' 'f1')