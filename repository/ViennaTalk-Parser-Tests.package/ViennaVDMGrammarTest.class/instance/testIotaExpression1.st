tests-expressions
testIotaExpression1
	self assert: (grammar expression end parse: 'iota v1 in set s & e') equals: #(#('v1' 's') 'e')