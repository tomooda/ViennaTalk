tests-code generation-expressions
testFieldSelectEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'x.field'.
	self deny: node isPetitFailure.
	self assert: node label = 'FieldSelect'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x'
								->
									((ViennaComposite constructorName: 'T' with: 1 with: 2)
										fieldNameAt: 1 put: 'field';
										fieldNameAt: 2 put: 'field2';
										storeString))} asDictionary))
		equals: 1