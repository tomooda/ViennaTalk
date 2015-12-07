tests-definitions
testAccessValueDefinition
	self assert: (grammar accessValueDefinition end parse: 'v = 0') equals: #(#() #('v' nil '0')).
	self assert: (grammar accessValueDefinition end parse: 'public v =0') equals: #(#('public') #('v' nil '0'))