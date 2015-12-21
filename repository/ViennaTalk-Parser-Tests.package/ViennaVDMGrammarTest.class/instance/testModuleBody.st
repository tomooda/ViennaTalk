tests-definitions
testModuleBody
	self assert: (grammar moduleBody end parse: 'definitions values v = 1') equals: #(#(#(#() #('v' nil '1'))))