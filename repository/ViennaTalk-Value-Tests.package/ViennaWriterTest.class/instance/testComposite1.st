tests
testComposite1
	self assert: (writer stringify: (VDMComposite type: #foo)) equals: 'mk_foo()'