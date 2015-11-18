tests-patterns
testMultipleBind1
	self assert: (grammar multipleBind end parse: 'v1,v2 in set e') equals: #(#('v1' 'v2') 'e')