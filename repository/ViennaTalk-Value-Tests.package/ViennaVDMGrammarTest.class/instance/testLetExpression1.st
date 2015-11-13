tests-expressions
testLetExpression1
	self assert: (grammar expression end parse: 'let x = <ok> in <ok>') equals: #(#(#('x' nil '<ok>')) '<ok>')