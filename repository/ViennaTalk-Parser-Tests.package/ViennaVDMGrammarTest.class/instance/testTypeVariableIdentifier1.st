tests-symbols
testTypeVariableIdentifier1
	self assert: (grammar typeVariableIdentifier end parse: '@v1v') equals: '@v1v'