tests-statements
testIndexForLoop
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement end
						parse: '(dcl a : seq of int := []; for v = 1 to 5 by 2 do a := a ^ [v] ; return a)'))
		equals: #(1 3 5) asOrderedCollection.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement end
						parse: '(dcl a : seq of int := []; for v = 1 to 3 do a := a ^ [v] ; return a)'))
		equals: #(1 2 3) asOrderedCollection