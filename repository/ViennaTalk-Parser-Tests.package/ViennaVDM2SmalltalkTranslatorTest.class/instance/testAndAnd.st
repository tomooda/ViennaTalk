tests-operators
testAndAnd
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true and true'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false and true'))
		equals: false.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 and true') ]
		raise: ZeroDivide.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true and false'))
		equals: false.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false and false'))
		equals: false.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 and false') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true and 1/0') ]
		raise: ZeroDivide.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false and 1/0'))
		equals: false.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 and 1/0') ]
		raise: ZeroDivide