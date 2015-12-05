tests-statements
testSequenceForLoop
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement end
						parse: '(dcl a : seq of int := []; for v in [1, 2, 3] do a := a ^ [v] ; return a)'))
		equals: #(1 2 3) asOrderedCollection