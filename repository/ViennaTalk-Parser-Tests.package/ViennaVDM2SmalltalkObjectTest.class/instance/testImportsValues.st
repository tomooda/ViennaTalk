tests-imports
testImportsValues
	self
		transpile:
			'
		module T
		exports all
		definitions
		values 
			zero = 0
		end T
		module M
		imports from T values zero
		exports all
		definitions
		functions
			isZero : int -> bool
			isZero(x) == x = T`zero
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`isZero(1)'))
						for: obj
						logged: false)
				equals: false.
			self
				assert: ( Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`isZero(0)'))
						for: obj
						logged: false )
				equals: true ]