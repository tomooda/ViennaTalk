tests
testIncludes
	self assert: (natBool includes: #(1 true)).
	self assert: (quoteBool includes: #(#QUOTE false))