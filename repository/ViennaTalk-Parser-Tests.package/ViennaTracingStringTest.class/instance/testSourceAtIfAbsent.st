tests
testSourceAtIfAbsent
	| abc xyz abcxyz |
	abc := 'abc' asViennaTracingString: 1.
	xyz := 'xyz'.
	abcxyz := abc , xyz.
	self assert: (abcxyz sourceAt: 1 ifAbsent: []) equals: 1.
	self assert: (abcxyz sourceAt: 4 ifAbsent: []) equals: nil.
