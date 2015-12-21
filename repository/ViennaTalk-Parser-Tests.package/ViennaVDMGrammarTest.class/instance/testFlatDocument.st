tests-definitions
testFlatDocument
	self assert: (grammar flatDocument end parse: 'values v = 1') equals: #(#(#(#() #('v' nil '1'))))