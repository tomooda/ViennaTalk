tests
testSeq2
	self assert: (writer stringify: #(1) asOrderedCollection) equals: '[1]'