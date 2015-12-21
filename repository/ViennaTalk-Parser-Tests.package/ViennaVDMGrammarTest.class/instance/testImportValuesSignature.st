tests-interfaces
testImportValuesSignature
	self
		assert: (grammar importValuesSignature end parse: 'values v1; v2 renamed v3')
		equals: #(#('v1' nil nil) #('v2' nil 'v3'))