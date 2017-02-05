tests-postconditions
testImplilcitFunctionPostcondition
	self
		transpile:
			'
	functions 
	pred(x:int) res:int
	post res - x = 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'post_pred(10, 11)'))
						for: obj
						logged: false)
				equals: true.
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'post_pred(10, 9)'))
						for: obj
						logged: false)
				equals: false.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(0)'))
						for: obj
						logged: false ]
				raise: ViennaImplicitEvaluationError ]