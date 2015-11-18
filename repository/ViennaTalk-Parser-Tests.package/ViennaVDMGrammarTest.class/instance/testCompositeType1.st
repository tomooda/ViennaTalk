tests-types
testCompositeType1
	self assert: (grammar type end parse: 'compose t of end') equals: #('t' #())