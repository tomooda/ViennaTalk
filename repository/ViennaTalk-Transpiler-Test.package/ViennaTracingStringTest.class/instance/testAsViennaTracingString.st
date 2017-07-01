tests
testAsViennaTracingString
	| abc |
	abc := 'abc' asViennaTracingString: 1.
	self assert: abc asViennaTracingString == abc