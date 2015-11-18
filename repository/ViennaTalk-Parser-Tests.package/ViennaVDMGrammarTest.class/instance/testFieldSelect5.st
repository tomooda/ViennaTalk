tests-types
testFieldSelect5
	self assert: (grammar expression end parse: 'f.f1()') equals: #(#('f' 'f1') #())