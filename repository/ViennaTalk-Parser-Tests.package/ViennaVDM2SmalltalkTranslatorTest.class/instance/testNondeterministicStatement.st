tests-statements
testNondeterministicStatement
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement end
						parse: '(dcl a : set of int := {}; ||(a := a union {1}, a := a union {2}, a := a union {3}); return a)'))
		equals: #(1 2 3) asSet