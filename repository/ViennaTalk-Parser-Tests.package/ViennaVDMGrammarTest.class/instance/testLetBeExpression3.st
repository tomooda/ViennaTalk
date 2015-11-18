tests-expressions
testLetBeExpression3
	self assert: (grammar expression end parse: 'let v1,v2 in set s in e') equals: #(#(#('v1' 'v2') 's') nil 'e')