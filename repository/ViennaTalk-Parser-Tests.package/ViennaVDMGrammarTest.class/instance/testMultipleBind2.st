tests-patterns
testMultipleBind2
	self assert: (grammar multipleBind end parse: 'v1,v2:e') equals: #(#('v1' 'v2') 'e')