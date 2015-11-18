tests-definitions
testValueDefinition1
	self assert: (grammar valueDefinition end parse: 'v:t=e') equals: #('v' 't' 'e')