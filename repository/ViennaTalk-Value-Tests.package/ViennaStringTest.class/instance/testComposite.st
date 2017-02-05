tests
testComposite
	self assert: (ViennaComposite constructorName: 'T') viennaString equals: 'mk_T()'.
	self assert: (ViennaComposite constructorName: 'T' with: 1) viennaString equals: 'mk_T(1)'.
	self
		assert: (ViennaComposite constructorName: 'T' with: 1 with: 2) viennaString
		equals: 'mk_T(1, 2)'