tests-patterns
testObjectPattern1
	self assert: (grammar pattern end parse: 'obj_T()') equals: #('T' #())