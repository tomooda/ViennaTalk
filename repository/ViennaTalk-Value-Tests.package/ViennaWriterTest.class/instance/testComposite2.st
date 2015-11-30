tests
testComposite2
	self assert: (writer stringify: (ViennaComposite constructorName: #foo with: 1)) equals: 'mk_foo(1)'