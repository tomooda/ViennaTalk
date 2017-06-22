tests
testSpace
	| abc |
	abc := ('abc' asViennaTracingString: 1).
	abc space.
	self assert: (abc at: 1) equals: $a.
	self assert: (abc at: 2) equals: $b.
	self assert: (abc at: 3) equals: $c.
	self assert: (abc at: 4) equals: Character space.
	self assert: (abc sourceAt: 1 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 2 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 3 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 4 ifAbsent: []) equals: nil.
	