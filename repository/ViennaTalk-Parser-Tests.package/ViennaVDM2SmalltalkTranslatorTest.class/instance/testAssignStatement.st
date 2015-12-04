tests-statements
testAssignStatement
	self
		assert: (Compiler evaluate: '| a |' , (ViennaVDM2SmalltalkTranslator new statement end parse: 'a := 2') , '. a')
		equals: 2.
	self
		assert:
			(Compiler
				evaluate:
					'| a b | a := #(0 0 0) asOrderedCollection. b := a. '
						, (ViennaVDM2SmalltalkTranslator new statement end parse: 'a(1) := 2') , '.  { a . b}')
		equals:
			{(#(2 0 0) asOrderedCollection).
			(#(0 0 0) asOrderedCollection)}