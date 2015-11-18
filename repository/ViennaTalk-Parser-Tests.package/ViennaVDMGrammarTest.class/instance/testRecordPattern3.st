tests-patterns
testRecordPattern3
	self assert: (grammar pattern end parse: 'mk_T(f,-)') equals: #('T' #('f' nil))