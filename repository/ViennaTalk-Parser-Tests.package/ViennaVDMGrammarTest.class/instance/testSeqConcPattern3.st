tests-patterns
testSeqConcPattern3
	self assert: (grammar pattern end parse: '[] ^ rest ^ tail') isPetitFailure