tests
testIsViennaTracingString
	| abc |
	abc := 'abc' asViennaTracingString: 1.
	self assert: abc isViennaTracingString .
	self deny: 'abc' isViennaTracingString.
	self deny: Object new isViennaTracingString