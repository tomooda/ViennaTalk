tests
testHash
	| abc |
	abc := 'abc' asViennaTracingString: 1.
	self assert: abc hash equals: 'abc' hash