tests-code generation-expressions
testOrEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'x or y'.
	self deny: node isPetitFailure.
	self assert: node label = 'Or'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'false')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> 'false')} asDictionary))
		equals: false.
	self
		should: [ 
			Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> self undefined)} asDictionary) ]
		raise: ViennaUndefinedEvaluationError.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> self undefined)} asDictionary))
		equals: true