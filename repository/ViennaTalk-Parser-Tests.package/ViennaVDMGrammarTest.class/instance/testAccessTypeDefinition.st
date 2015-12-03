tests-definitions
testAccessTypeDefinition
	self assert: (grammar accessTypeDefinition end parse: 't = t1') equals: #(#(nil nil) #('t' 't1' nil)).
	self assert: (grammar accessTypeDefinition end parse: 'public t = t1') equals: #(#('public' nil) #('t' 't1' nil)).
	self assert: (grammar accessTypeDefinition end parse: 'static t = t1') equals: #(#(nil 'static') #('t' 't1' nil)).
	self
		assert: (grammar accessTypeDefinition end parse: 'static protected t = t1')
		equals: #(#('protected' 'static') #('t' 't1' nil)).
	self
		assert: (grammar accessTypeDefinition end parse: 'private static t = t1')
		equals: #(#('private' 'static') #('t' 't1' nil))