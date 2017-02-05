tests-postconditions
testImplilcitOperationPostcondition
	self
		transpile:
			'
	operations 
	pred(x:int) res:int
	pre x > 0
	post res - x = 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate:
							(transpiler
								generate: (ViennaVDMParser new expression parse: 'post_pred(10, nil, nil, 11)'))
						for: obj
						logged: false)
				equals: true.
			self
				assert:
					(Compiler
						evaluate:
							(transpiler
								generate: (ViennaVDMParser new expression parse: 'post_pred(10, nil, nil, 9)'))
						for: obj
						logged: false)
				equals: false.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(10)'))
						for: obj
						logged: false ]
				raise: ViennaImplicitEvaluationError.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(0)'))
						for: obj
						logged: false ]
				raise: ViennaPreconditionViolation ]