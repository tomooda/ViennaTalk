tests
testComposite2
	self assert: (reader parse: 'mk_foo(1)') equals: (ViennaComposite type: #foo with: 1)