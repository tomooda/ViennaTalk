tests-patterns
testMultipleTypeBind1
	self assert: (grammar multipleTypeBind end parse: 'v1,v2:e') equals: #(#('v1' 'v2') 'e')