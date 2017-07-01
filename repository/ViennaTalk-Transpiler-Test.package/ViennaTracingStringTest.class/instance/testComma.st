tests
testComma
	| abc xyz abcxyz |
	abc := 'abc' asViennaTracingString: 1.
	xyz := 'xyz' asViennaTracingString: 2.
	abcxyz := abc , xyz.
	self assert: abc string equals: 'abc'.
	self assert: abc sources equals: (OrderedCollection with: (1 to: 3) -> 1).
	self assert: xyz string equals: 'xyz'.
	self assert: xyz sources equals: (OrderedCollection with: (1 to: 3) -> 2).
	self assert: abcxyz string equals: 'abcxyz'.
	self assert: abcxyz sources equals: (OrderedCollection with: (1 to: 3) -> 1 with: (4 to: 6) -> 2)