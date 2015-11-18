tests-expressions
testRecordConstructor6
	self assert: (grammar expression end parse: 'mk_ t(e1,e2,e3)') isPetitFailure