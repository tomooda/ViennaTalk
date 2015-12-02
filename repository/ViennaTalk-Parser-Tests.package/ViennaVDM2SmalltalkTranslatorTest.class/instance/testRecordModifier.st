tests-expressions
testRecordModifier
	self
		assert:
			(Compiler
				evaluate:
					' | type value | type := ViennaCompositeType constructorName: ''T'' withAll: {{ nil . false . ViennaType int} . {''f'' . false . ViennaType int} . {''g'' . true . ViennaType nat}}. value := type valueWithArguments: #(10 20 30). '
						, (ViennaVDM2SmalltalkTranslator new expression end parse: 'mu(value, f |-> 1, g |-> 2)'))
		equals: (ViennaComposite constructorName: 'T' withAll: #(10 1 2))