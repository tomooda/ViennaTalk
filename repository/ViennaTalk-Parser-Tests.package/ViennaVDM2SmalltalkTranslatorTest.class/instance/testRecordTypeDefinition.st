tests-definitions
testRecordTypeDefinition
	self
		assert:
			(Compiler
				evaluate:
					'| T |' , (ViennaVDM2SmalltalkTranslator new recordTypeDefinition end parse: 'T::nat f2:int f3:-bool') , 'T')
		equals:
			(ViennaCompositeType
				constructorName: 'T'
				withAll:
					{{nil.
					false.
					(ViennaType nat)}.
					{'f2'.
					false.
					(ViennaType int)}.
					{'f3'.
					true.
					(ViennaType bool)}}).
	self
		assert:
			(Compiler
				evaluate:
					'| T |' , (ViennaVDM2SmalltalkTranslator new recordTypeDefinition end parse: 'T::nat inv mk_T(x) == x < 10')
						, 'T includes: (T applyTo: #(1))')
		equals: true.
	self
		should: [ 
			Compiler
				evaluate:
					'| T |' , (ViennaVDM2SmalltalkTranslator new recordTypeDefinition end parse: 'T::nat inv mk_T(x) == x < 10')
						, 'T applyTo: #(10)' ]
		raise: ViennaInvariantViolation