tests-types
testBasicType
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'bool')) equals: ViennaType bool.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'nat1')) equals: ViennaType nat1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'nat')) equals: ViennaType nat.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'int')) equals: ViennaType int.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'real')) equals: ViennaType real.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'char')) equals: ViennaType char.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'token')) equals: ViennaType token