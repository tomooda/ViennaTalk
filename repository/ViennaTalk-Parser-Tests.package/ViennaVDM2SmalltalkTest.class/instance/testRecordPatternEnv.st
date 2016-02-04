tests-code generation-patterns
testRecordPatternEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'def  mk_T(x, y) = mk_T(1, 2) in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'RecordPattern'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('T' -> '(ViennaType compose: ''T'' of: {{nil. false. (ViennaType nat)}. {nil. false. (ViennaType nat)}})')}
								asDictionary))
		equals: 3