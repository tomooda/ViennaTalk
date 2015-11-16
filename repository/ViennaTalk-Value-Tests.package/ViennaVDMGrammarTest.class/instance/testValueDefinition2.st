tests-definitions
testValueDefinition2
	self assert: (grammar valueDefinition end parse: 'v=e') equals: #('v' nil 'e')