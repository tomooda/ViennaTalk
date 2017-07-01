tests
testJoin
	| a b c abc |
	a := 'a' asViennaTracingString: 1.
	b := 'b'.
	c := 'c' asViennaTracingString: 3.
	abc := ' ' asViennaTracingString join: { a . b . c }.
	self assert: abc asString equals: 'a b c' .
	self assert: (abc sourceAt: 1 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 2 ifAbsent: []) equals: nil.
	self assert: (abc sourceAt: 3 ifAbsent: []) equals: nil.
	self assert: (abc sourceAt: 4 ifAbsent: []) equals: nil.
	self assert: (abc sourceAt: 5 ifAbsent: []) equals: 3.
