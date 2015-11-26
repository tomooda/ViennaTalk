tests-operators
testModAnd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '3 mod 2')) equals: 1