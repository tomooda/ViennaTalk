tests-statements
testSequenceForLoop
	self assert: (grammar statement end parse: 'for v in e1 do return e2') equals: #('v' 'e1' 'e2')