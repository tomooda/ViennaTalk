tests
testComposite3
	self
		assert: (reader parse: 'mk_foo(1,2,3)')
		equals:
			(ViennaComposite
				constructorName: #foo
				with: 1
				with: 2
				with: 3)