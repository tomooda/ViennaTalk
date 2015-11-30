tests
testIncludes
	self assert: (quote includes: #'<QUOTE>').
	self deny: (quote includes: '<QUOTE>').
	self deny: (quote includes: $a)