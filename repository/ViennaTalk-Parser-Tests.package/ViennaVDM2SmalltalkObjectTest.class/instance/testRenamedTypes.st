tests-imports
testRenamedTypes
	self
		transpile:
			'
		module T
		exports all
		definitions
		types 
			n = int inv x == x >= 0
		end T
		module M
		imports from T types n renamed n0
		exports all
		definitions
		functions
			succ : n0 -> n0
			succ(x) == x + 1
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`succ(1)'))
						for: obj
						logged: false)
				equals: 2.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`succ(-1)'))
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError ]