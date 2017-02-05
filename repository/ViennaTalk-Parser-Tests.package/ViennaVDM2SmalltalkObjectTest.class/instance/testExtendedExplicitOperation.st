tests-type checking
testExtendedExplicitOperation
	self
		transpile:
			'
	state State of 
		count : int
		init s == s = mk_State(10) 
	end
	operations 
	sub(x:nat) res:nat == (count := count - x; return count)
	post count + x = count~ and count = res;'
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
			self assert: (obj instVarNamed: 'count') equals: 1.
			self
				assert:
					(Compiler
						evaluate:
							(transpiler
								generate: (ViennaVDMParser new expression parse: 'post_sub(1, mk_State(9), mk_State(10), 9)'))
						for: obj
						logged: false)
				equals: true ]