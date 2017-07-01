tests-code generation-expressions
testAndEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'x and y'.
	self deny: node isPetitFailure.
	self assert: node label = 'And'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'false')} asDictionary))
		equals: false.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> self undefined)} asDictionary))
		equals: false.
	self
		should: [ 
			Compiler
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> self undefined)} asDictionary) ]
		raise: ViennaUndefinedEvaluationError