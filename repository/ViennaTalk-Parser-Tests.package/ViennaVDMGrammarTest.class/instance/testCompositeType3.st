tests-types
testCompositeType3
	self
		assert: (grammar type end parse: 'compose t of v1:t1 v2:-t2 t3 end')
		equals: #('t' #(#('v1' 't1') #('v2' 't2') 't3'))