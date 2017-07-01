tests-code generation-statements
testFieldReferenceEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'x.f := 1'.
	self deny: node isPetitFailure.
	self assert: node first label = 'FieldReference'.
	self
		assert:
			(Compiler
				evaluate:
					'|x|x:=(ViennaComposite constructorName:''T'' with: nil with: 2) fieldNameAt: 1 put: ''f''; yourself.'
						, (ViennaVDM2SmalltalkScript new generate: node) , '. {x at: 1. x at: 2}')
		equals:
			{1.
			2}