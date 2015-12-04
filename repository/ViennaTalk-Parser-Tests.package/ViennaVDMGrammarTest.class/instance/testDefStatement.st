tests-statements
testDefStatement
	self assert: (grammar statement end parse: 'def v:t = e in skip') equals: #(#(#(#('v' 't') 'e')) nil)