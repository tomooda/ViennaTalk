tests-definitions
testExplicitOperationDefinition
	self
		assert: (grammar operationDefinition end parse: 'op : nat==> () op(x) == return x pre e1 post e2')
		equals: #('op' #('nat' nil) 'op' #('x') 'x' 'e1' 'e2')