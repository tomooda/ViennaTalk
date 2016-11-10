tests-postconditions
testFunctionPostcondition
	self
		transpile:
			'
	functions 
	pred : int -> int 
	pred(x) == x - 1
	post RESULT >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(10)') )
						for: obj
						logged: false)
				equals: 9.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(0)') )
						for: obj
						logged: false ]
				raise: ViennaPostconditionViolation ]