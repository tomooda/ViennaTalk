tests-patterns
testSeqConcPattern2
	self assert: (grammar pattern end parse: '[] ^ rest') equals: #(#() 'rest')