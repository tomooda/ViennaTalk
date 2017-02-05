tests-code generation-definitions
testExtendedExplicitFunction
	| code |
	code := ViennaVDM2SmalltalkScript new
		translate:
			'
	functions 
	succ(x:int) res:int == x + 1
	post res = x + 1;'
		ifError: [ self fail ].
	self
		assert: (Compiler evaluate: code , '. succ value: 0' for: nil logged: false)
		equals: 1.
	self
		assert:
			(Compiler
				evaluate: code , '. post_succ value: 0 value: 1'
				for: nil
				logged: false).
	self
		deny:
			(Compiler
				evaluate: code , '. post_succ value: 0 value: 2'
				for: nil
				logged: false)