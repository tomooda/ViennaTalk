tests-patterns
testObjectPattern2
	self assert: (grammar pattern end parse: 'obj_T(f|->-)') equals: #('T' #(#('f' nil)))