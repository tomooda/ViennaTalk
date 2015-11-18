tests-expressions
testLetBeExpression1
	self assert: (grammar expression end parse: 'let v1,v2:t in e') equals: #(#(#('v1' 'v2') 't') nil 'e')