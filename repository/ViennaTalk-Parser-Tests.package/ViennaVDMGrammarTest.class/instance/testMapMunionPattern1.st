tests-patterns
testMapMunionPattern1
	self assert: (grammar pattern end parse: 'a munion b') equals: #(#a #b)