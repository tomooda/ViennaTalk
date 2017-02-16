tests
testIncludes
	self
		assert:
			(composite
				includes:
					(ViennaComposite
						constructorName: 'T'
						with: -1
						with: 1
						with: #QUOTE)).
	self deny: (composite includes: 1)