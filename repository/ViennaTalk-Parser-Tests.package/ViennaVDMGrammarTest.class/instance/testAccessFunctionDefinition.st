tests-definitions
testAccessFunctionDefinition
	self
		assert: (grammar accessFunctionDefinition end parse: 'f : t1 -> t1 f(v)==e')
		equals: #(#() #('f' #() #('t1' 't1') 'f' #(#('v')) 'e' nil nil nil)).
	self
		assert: (grammar accessFunctionDefinition end parse: 'private f : t1 -> t1 f(v)==e')
		equals: #(#('private') #('f' #() #('t1' 't1') 'f' #(#('v')) 'e' nil nil nil))