tests-types
testFieldSelect4
	self assert: (grammar expression end parse: 'f().f1') equals: #(#('f' #()) 'f1')