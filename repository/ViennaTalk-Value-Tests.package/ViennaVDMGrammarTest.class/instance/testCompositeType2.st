tests-types
testCompositeType2
	self assert: (grammar type end parse: 'compose t of v1:t1 end') equals: #('t' #(#('v1' 't1')))