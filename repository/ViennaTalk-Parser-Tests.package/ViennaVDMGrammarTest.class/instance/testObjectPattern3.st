tests-patterns
testObjectPattern3
	self assert: (grammar pattern end parse: 'obj_T(f1|->-,f2|->v1)') equals: #('T' #(#('f1' nil) #('f2' 'v1')))