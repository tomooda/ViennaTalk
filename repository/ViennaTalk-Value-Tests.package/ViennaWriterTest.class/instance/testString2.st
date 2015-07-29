tests
testString2
	self assert: (writer stringify: (String with: (Character codePoint: 16r1234))) equals: '"\u1234"'