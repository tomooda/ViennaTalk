tests-operators
testOrAnd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true or true')) equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false or true'))
		equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 or true') ]
		raise: ZeroDivide.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true or false'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false or false'))
		equals: false.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 or false') ]
		raise: ZeroDivide.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true or 1/0')) equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false or 1/0') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 or 1/0') ]
		raise: ZeroDivide