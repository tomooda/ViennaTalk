tests
testComposite2
	self assert: (reader parse: 'mk_foo(1)') equals: (VDMComposite type: #foo with: 1)