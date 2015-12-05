tests-statements
testCallStatement
	self assert: (grammar statement end parse: 'f(e1,e2,e3)') equals: #('f' #('e1' 'e2' 'e3')).
	self assert: (grammar statement end parse: 'f()') equals: #('f' #())