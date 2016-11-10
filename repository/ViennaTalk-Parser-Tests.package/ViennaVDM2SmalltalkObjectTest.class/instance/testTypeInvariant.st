tests-invariants
testTypeInvariant
	self
		transpile:
			'
	types
		N0 = int inv n == n >= 0
	state State of 
		count : N0
		init s == s = mk_State(10) 
	end
	operations 
	sub : int ==> int 
	sub(x) == (count := count - x; return count);'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)'))
						for: obj
						logged: false)
				equals: 1.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)'))
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError.
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'is_N0(1)') )
						for: obj
						logged: false)
				equals: true.
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'is_N0(-1)') )
						for: obj
						logged: false)
				equals: false ]