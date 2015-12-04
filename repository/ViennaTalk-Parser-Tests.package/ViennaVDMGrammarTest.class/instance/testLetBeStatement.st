tests-statements
testLetBeStatement
	self assert: (grammar statement end parse: 'let v in set s be st e in skip') equals: #(#(#('v') 's') 'e' nil).
	self assert: (grammar statement end parse: 'let v in set s in skip') equals: #(#(#('v') 's') nil nil)