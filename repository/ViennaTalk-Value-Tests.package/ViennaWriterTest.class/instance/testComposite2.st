tests
testComposite2
	self assert: (writer stringify: (VDMComposite type: #foo with: 1)) equals: 'mk_foo(1)'