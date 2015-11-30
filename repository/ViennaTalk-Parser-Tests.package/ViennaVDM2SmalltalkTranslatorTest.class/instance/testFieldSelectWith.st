tests-operators
testFieldSelectWith
	self
		assert:
			(Compiler
				evaluate:
					' | type value | type := ViennaCompositeType constructorName: ''T'' withAll: {{ nil . false . ViennaType int} . {''f'' . false . ViennaType int}}. value := type valueWithArguments: #(10 20). '
						, (ViennaVDM2SmalltalkTranslator new expression end parse: 'value.f'))
		equals: 20.
	self
		should: [ 
			Compiler
				evaluate:
					' | type value | type := ViennaCompositeType constructorName: ''T'' withAll: {{ nil . false . ViennaType int} . {''f'' . false . ViennaType int}}. value := type valueWithArguments: #(10 20). '
						, (ViennaVDM2SmalltalkTranslator new expression end parse: 'value.g') ]
		raise: KeyNotFound