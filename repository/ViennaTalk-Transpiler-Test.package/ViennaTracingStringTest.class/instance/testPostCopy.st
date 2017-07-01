tests
testPostCopy
	| abc copy |
	abc := 'abc' asViennaTracingString.
	copy := abc copy.
	abc nextPutAll: 'xyz'.
	self assert: abc asString equals: 'abcxyz'.
	self assert: copy asString equals: 'abc'