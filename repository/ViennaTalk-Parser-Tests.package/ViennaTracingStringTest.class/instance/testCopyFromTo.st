tests
testCopyFromTo
	| abcxyz bcxy |
	abcxyz := ('abc' asViennaTracingString: 1), ('xyz' asViennaTracingString: 2).
	bcxy := abcxyz copyFrom: 2 to: 5.
	self assert: (bcxy at: 1) equals: $b.
	self assert: (bcxy at: 2) equals: $c.
	self assert: (bcxy at: 3) equals: $x.
	self assert: (bcxy at: 4) equals: $y.
	self assert: (bcxy sourceAt: 1 ifAbsent: []) equals: 1.
	self assert: (bcxy sourceAt: 2 ifAbsent: []) equals: 1.
	self assert: (bcxy sourceAt: 3 ifAbsent: []) equals: 2.
	self assert: (bcxy sourceAt: 4 ifAbsent: []) equals: 2.
	