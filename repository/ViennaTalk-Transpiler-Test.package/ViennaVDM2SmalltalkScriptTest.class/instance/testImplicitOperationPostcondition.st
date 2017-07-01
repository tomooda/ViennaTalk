tests-code generation-definitions
testImplicitOperationPostcondition
	| code |
	code := ViennaVDM2SmalltalkScript new
		translate:
			'
	state S of
		v : int
		init s == s = mk_S(0)
	end
	operations 
	succ(x:int) res:int
	post res = x + 1;'
		ifError: [ self fail ].
	self
		should: [ Compiler evaluate: code , '. succ value: 1' for: nil logged: false ]
		raise: ViennaImplicitEvaluationError.
	self
		assert:
			(Compiler
				evaluate: code , '. post_succ value: 0 value: 1 value: (S value: 0) value: (S value: 0)'
				for: nil
				logged: false).
	self
		deny:
			(Compiler
				evaluate: code , '. post_succ value: 0 value: 2 value: (S value: 0) value: (S value: 0)'
				for: nil
				logged: false)