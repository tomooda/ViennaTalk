tests-interfaces
testImportTypesSignature
	self
		assert: (grammar importTypesSignature end parse: 'types t1; t2 renamed t3; t4 = t5 renamed t6; t7;')
		equals: #(#('t1' nil) #('t2' 't3') #(#('t4' 't5' nil) 't6') #('t7' nil))