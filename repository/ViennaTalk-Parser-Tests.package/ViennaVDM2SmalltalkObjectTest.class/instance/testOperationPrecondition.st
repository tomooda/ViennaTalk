tests-preconditions
testOperationPrecondition
	self
		transpile:
			'
	state State of 
		count : nat
		init s == s = mk_State(10) 
	end
	operations 
	sub : nat ==> nat 
	sub(x) == (count := count - x; return count)
	pre count >= x;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj  :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') )
						for: obj
						logged: false)
				equals: 1.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') )
						for: obj
						logged: false ]
				raise: ViennaPreconditionViolation ]