tests
testSeq3
	self assert: (writer stringify: #(1 2 3) asOrderedCollection) equals: '[1,2,3]'