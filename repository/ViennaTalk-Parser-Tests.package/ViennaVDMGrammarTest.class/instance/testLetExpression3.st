tests-expressions
testLetExpression3
	self
		assert: (grammar expression end parse: 'let x:<ok> = <ok>, y=<ok> in <ok>')
		equals: #(#(#('x' '<ok>' '<ok>') #('y' nil '<ok>')) '<ok>')