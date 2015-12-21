tests-interfaces
testInterface
	self
		assert: (grammar interface end parse: 'imports from m1 values v1; v2 functions f ; values v, from m2 all exports all')
		equals: #(#(#('m1' #(#(#('v1' nil nil) #('v2' nil nil)) #(#('f' nil nil)) #(#('v' nil nil)))) #('m2' 'all')) 'all').
	self assert: (grammar interface end parse: 'exports values v1:t1') equals: #(nil #(#(#(#('v1') 't1'))))