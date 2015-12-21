tests-definitions
testModule
	self
		assert: (grammar module end parse: 'module m exports all definitions values v = 1 end m')
		equals: #('m' #(nil 'all') #(#(#(#() #('v' nil '1'))))).
	self assert: (grammar module end parse: 'module m1 exports all definitions values v = 1 end m2') isPetitFailure