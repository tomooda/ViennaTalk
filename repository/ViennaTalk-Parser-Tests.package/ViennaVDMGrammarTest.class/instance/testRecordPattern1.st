tests-patterns
testRecordPattern1
	self assert: (grammar pattern end parse: 'mk_T()') equals: #('T' #())