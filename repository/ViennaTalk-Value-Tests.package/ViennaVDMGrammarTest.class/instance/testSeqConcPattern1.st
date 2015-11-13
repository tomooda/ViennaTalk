tests-patterns
testSeqConcPattern1
	self assert: (grammar pattern end parse: '[]^rest') equals: #(#() 'rest')