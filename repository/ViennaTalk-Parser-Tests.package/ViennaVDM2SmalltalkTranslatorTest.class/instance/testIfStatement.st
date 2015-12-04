tests-statements
testIfStatement
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement
						parse: '(dcl x:nat := 0; if x = 1 then return "1" elseif x = 2 then return "2"  else return "other")'))
		equals: 'other' asOrderedCollection.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement
						parse: '(dcl x:nat := 1; if x = 1 then return "1" elseif x = 2 then return "2"  else return "other")'))
		equals: '1' asOrderedCollection.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new statement
						parse: '(dcl x:nat := 2; if x = 1 then return "1" elseif x = 2 then return "2"  else return "other")'))
		equals: '2' asOrderedCollection