tests-patterns
testMultipleSetBind1
	self assert: (grammar multipleSetBind end parse: 'v1,v2 in set e') equals: #(#('v1' 'v2') 'e')