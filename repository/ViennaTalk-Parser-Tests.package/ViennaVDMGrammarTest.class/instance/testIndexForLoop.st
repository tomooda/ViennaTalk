tests-statements
testIndexForLoop
	self assert: (grammar statement end parse: 'for v = e1 to e2 by e3 do return e4') equals: #('v' 'e1' 'e2' 'e3' 'e4').
	self assert: (grammar statement end parse: 'for v = e1 to e2 do return e3') equals: #('v' 'e1' 'e2' nil 'e3')