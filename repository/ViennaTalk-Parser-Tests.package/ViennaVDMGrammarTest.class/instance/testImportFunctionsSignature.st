tests-interfaces
testImportFunctionsSignature
	self
		assert: (grammar importFunctionsSignature end parse: 'functions f1; f2 renamed f3')
		equals: #(#('f1' nil nil nil) #('f2' nil nil 'f3'))