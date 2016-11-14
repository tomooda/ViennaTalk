tests-imports
testRenamedFunctions
	self
		transpile:
			'
		module T
		exports all
		definitions
		functions 
			succ : nat -> nat
			succ(x) == x + 1;
		end T
		module M
		imports from T functions succ renamed successor
		exports all
		definitions
		functions
			next : int -> int
			next(x) == successor(x)
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`next(1)'))
						for: obj
						logged: false)
				equals: 2.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`next(-1)'))
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError ]