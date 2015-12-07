tests-definitions
testAccessOperationDefinition
	self
		assert: (grammar accessOperationDefinition end parse: 'op : t1 ==> t2 op(v)==return e')
		equals: #(#() #('op' #('t1' 't2') 'op' #('v') 'e' nil nil)).
	self
		assert: (grammar accessOperationDefinition end parse: 'pure async static public op : t1 ==> t2 op(v)==return e')
		equals: #(#('pure' 'async' 'static' 'public') #('op' #('t1' 't2') 'op' #('v') 'e' nil nil))