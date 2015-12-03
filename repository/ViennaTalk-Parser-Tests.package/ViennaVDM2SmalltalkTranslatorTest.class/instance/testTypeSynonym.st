tests-definitions
testTypeSynonym
	self
		assert:
			(Compiler evaluate: ' | T |' , (ViennaVDM2SmalltalkTranslator new typeSynonym end parse: 'T = nat') second , 'T')
		equals: ViennaType nat.
	self
		assert:
			(Compiler
				evaluate:
					' | T |' , (ViennaVDM2SmalltalkTranslator new typeSynonym end parse: 'T = nat inv n == n < 10') second , 'T includes: 9')
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					' | T |' , (ViennaVDM2SmalltalkTranslator new typeSynonym end parse: 'T = nat inv n == n < 10') second
						, 'T includes: 10')
		equals: false