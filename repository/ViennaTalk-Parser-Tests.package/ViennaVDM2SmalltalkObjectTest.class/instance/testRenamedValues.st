tests-imports
testRenamedValues
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
		imports from T values zero renamed z
		exports all
		definitions
		functions
			isZero : int -> bool
			isZero(x) == x = z
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
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`isZero(0)'))
						for: obj
						logged: false)
				equals: true ]