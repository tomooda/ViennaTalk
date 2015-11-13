tests-types
testTypeName3
	self assert: (grammar type end parse: 'm1 ` t1') equals: #('m1' 't1')