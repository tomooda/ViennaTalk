tests
testComposite1
	self assert: (writer stringify: (ViennaComposite type: #foo)) equals: 'mk_foo()'