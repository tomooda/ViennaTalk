tests-statements
testWhileLoop
	self assert: (grammar statement end parse: 'while e1 do return e2') equals: #('e1' 'e2')