tests-preconditions
testFunctionPrecondition
	self
		transpile:
			'
	functions 
	pred : int -> int 
	pred(x) == x - 1
	pre x > 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(9)'))
						for: obj
						logged: false)
				equals: 8.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(-1)'))
						for: obj
						logged: false ]
				raise: ViennaPreconditionViolation ]