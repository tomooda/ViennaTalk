tests-code generation-expressions
testRecordConstructorEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'mk_T(1,2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'RecordConstructor'.
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
			((ViennaComposite constructorName: 'T' with: 1 with: 2)
				fieldNameAt: 1 put: 'f1';
				fieldNameAt: 2 put: 'f2';
				yourself)