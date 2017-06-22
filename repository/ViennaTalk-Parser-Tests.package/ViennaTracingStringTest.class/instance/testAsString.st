tests
testAsString
	self assert: ('abc' , ('xyz' asViennaTracingString: 1)) asString equals: 'abc' , 'xyz'