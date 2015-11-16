tests-expressions
testLambdaExpression1
	self assert: (grammar expression end parse: 'lambda v1:t1,v2:t2&e') equals: #(#(#('v1' 't1') #('v2' 't2')) 'e')