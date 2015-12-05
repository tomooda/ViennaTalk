tests-statements
testSetForLoop
	self assert: (grammar statement end parse: 'for all v in set e1 do return e2') equals: #('v' 'e1' 'e2')