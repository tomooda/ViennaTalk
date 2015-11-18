tests-expressions
testLetBeExpression2
	self assert: (grammar expression end parse: 'let v1,v2:t be st e1 in e2') equals: #(#(#('v1' 'v2') 't') 'e1' 'e2')