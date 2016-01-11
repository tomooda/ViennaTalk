tests
testComposite3
	self assert: (writer stringify: (ViennaComposite constructorName: #foo with: 1 with: 2 with: 3)) equals: 'mk_foo(1, 2, 3)'