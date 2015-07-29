tests
testSeq1
	self assert: (writer stringify: #() asOrderedCollection) equals: '[]'