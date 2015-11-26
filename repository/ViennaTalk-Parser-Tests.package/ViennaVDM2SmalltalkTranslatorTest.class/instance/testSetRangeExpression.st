tests-expressions
testSetRangeExpression
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '{1,...,10}')) equals: (1 to: 10) asSet