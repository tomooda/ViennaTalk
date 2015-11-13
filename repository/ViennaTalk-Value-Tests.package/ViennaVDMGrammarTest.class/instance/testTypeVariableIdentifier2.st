tests-symbols
testTypeVariableIdentifier2
	self assert: (grammar typeVariableIdentifier end parse: '@ v1v') equals: '@v1v'