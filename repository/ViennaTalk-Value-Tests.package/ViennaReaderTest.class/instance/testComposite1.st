tests
testComposite1
	self assert: (reader parse: 'mk_foo()') equals: (ViennaComposite type: #foo)