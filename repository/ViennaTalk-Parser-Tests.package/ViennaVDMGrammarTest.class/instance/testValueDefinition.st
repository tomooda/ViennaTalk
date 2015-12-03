tests-definitions
testValueDefinition
	self assert: (grammar valueDefinition end parse: 'v:t=e') equals: #('v' 't' 'e').
	self assert: (grammar valueDefinition end parse: 'v=e') equals: #('v' nil 'e')