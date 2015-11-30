tests
testIncludes
	self assert: (natBool includes: 1).
	self assert: (natBool includes: true).
	self assert: (quoteBool includes: #'<QUOTE>').
	self assert: (quoteBool includes: false).
	self deny: (quoteBool includes: #'<NOQUOTE>')