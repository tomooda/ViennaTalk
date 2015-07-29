tests
testChar2
	self assert: (writer stringify: (Character codePoint: 16r1234)) equals: '''\u1234'''