tests
testComposite2
	self assert: (reader parse: 'mk_foo(1)') equals: (ViennaComposite constructorName: #foo with: 1)