tests-code generation-expressions
testRecordModifierEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'mu(mk_T(1,2), f1|->11, f2|->12)'.
	self deny: node isPetitFailure.
	self assert: node label = 'RecordModifier'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('T'
								->
									(ViennaCompositeType
										constructorName: 'T'
										withAll:
											{{'f1'.
											false.
											(ViennaType nat)}.
											{'f2'.
											false.
											(ViennaType nat)}}) storeString)} asDictionary))
		equals:
			((ViennaComposite constructorName: 'T' with: 11 with: 12)
				fieldNameAt: 1 put: 'f1';
				fieldNameAt: 2 put: 'f2';
				yourself)