tests-code generation-statements
testMapOrSequenceReferenceEnv
	| node |
	node := ViennaVDMParser new statement end parse: 'x("key") := 1'.
	self deny: node isPetitFailure.
	self assert: node first label = 'MapOrSequenceReference'.
	self
		assert:
			(Compiler
				evaluate:
					'|x|x:={''key''->nil. 2 -> 2} asDictionary.' , (ViennaVDM2SmalltalkScript new generate: node) , '. {x at: ''key''. x at: 2}')
		equals:
			{1.
			2}.
	node := ViennaVDMParser new statement end parse: 'x(1) := 1'.
	self deny: node isPetitFailure.
	self assert: node first label = 'MapOrSequenceReference'.
	self
		assert:
			(Compiler
				evaluate: '|x|x:={nil . 2} asOrderedCollection.' , (ViennaVDM2SmalltalkScript new generate: node) , '. {x at: 1. x at: 2}')
		equals:
			{1.
			2}