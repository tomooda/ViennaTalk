tests-definitions
testDocument
	self assert: (grammar document end parse: 'values v = 1') equals: #(#(#(#() #('v' nil '1')))).
	self
		assert:
			(grammar document end parse: 'module m1 exports all definitions values v = 1 end m1 module m2 exports all  end m2')
		equals: #(#('m1' #(nil 'all') #(#(#(#() #('v' nil '1'))))) #('m2' #(nil 'all') nil))