tests-expressions
testLetExpression2
	self assert: (grammar expression end parse: 'let x:<ok> = <ok> in <ok>') equals: #(#(#('x' '<ok>' '<ok>')) '<ok>')