tests-definitions
testDocument
	self
		assert:
			(Compiler
				evaluate: (ViennaVDM2SmalltalkTranslator new document end parse: 'types T = nat inv n == n < 10;') , 'T includes: 9')
		equals: true