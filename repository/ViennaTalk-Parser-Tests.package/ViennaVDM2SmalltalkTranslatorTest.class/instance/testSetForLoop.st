tests-statements
testSetForLoop
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement end
						parse: '(dcl a : seq of int := []; for all v in set {1, ..., 3} do a := a ^ [v] ; return a)'))
		equals: #(1 2 3) asOrderedCollection