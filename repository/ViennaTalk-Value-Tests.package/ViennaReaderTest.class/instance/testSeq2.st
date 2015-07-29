tests
testSeq2
	self assert: (reader parse: '[1]') equals: #(1) asOrderedCollection