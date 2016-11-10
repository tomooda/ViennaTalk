tests-type checking
testFunctionTypecheck
	self
		transpile:
			'
	functions 
	pred : nat -> nat 
	pred(x) == x - 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(9)') )
						for: obj
						logged: false)
				equals: 8.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(0)') )
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(-1)') )
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError ]