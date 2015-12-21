tests-interfaces
testImportModuleSignature
	self
		assert: (grammar importModuleSignature end parse: 'values v1; v2 functions f ; values v')
		equals: #(#(#('v1' nil nil) #('v2' nil nil)) #(#('f' nil nil)) #(#('v' nil nil))).
	self assert: (grammar importModuleSignature end parse: 'all') equals: 'all'