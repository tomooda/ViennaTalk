tests-expressions
testUndefinedExpression
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'undefined') ]
		raise: ViennaUndefined.
	self
		shouldnt: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'if true then 1 else undefined') ]
		raise: ViennaUndefined