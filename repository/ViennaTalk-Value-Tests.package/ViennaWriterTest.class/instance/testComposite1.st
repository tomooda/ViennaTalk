tests
testComposite1
	self assert: (writer stringify: (ViennaComposite constructorName: #foo)) equals: 'mk_foo()'