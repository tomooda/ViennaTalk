tests-statements
testWhileLoop
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement end parse: '(dcl a : nat := 1; while a < 3 do a := a + 1; return a)'))
		equals: 3