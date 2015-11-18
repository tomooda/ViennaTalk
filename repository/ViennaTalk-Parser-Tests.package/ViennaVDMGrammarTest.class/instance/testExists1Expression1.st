tests-expressions
testExists1Expression1
	self assert: (grammar expression end parse: 'exists1 v1 in set s & e') equals: #(#('v1' 's') 'e')