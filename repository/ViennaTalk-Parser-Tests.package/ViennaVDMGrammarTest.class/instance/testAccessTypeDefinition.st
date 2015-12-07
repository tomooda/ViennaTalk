tests-definitions
testAccessTypeDefinition
	self assert: (grammar accessTypeDefinition end parse: 't = t1') equals: #(#() #('t' 't1' nil)).
	self assert: (grammar accessTypeDefinition end parse: 'public t = t1') equals: #(#('public') #('t' 't1' nil)).
	self assert: (grammar accessTypeDefinition end parse: 'static t = t1') equals: #(#('static') #('t' 't1' nil)).
	self
		assert: (grammar accessTypeDefinition end parse: 'static protected t = t1')
		equals: #(#('static' 'protected') #('t' 't1' nil)).
	self
		assert: (grammar accessTypeDefinition end parse: 'private static t = t1')
		equals: #(#('static' 'private') #('t' 't1' nil))