tests-operators
testEquivAnd
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true <=> true'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false <=> true'))
		equals: false.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 <=> true') ]
		raise: ZeroDivide.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true <=> false'))
		equals: false.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false <=> false'))
		equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 <=> false') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true <=> 1/0') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false <=> 1/0') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 <=> 1/0') ]
		raise: ZeroDivide