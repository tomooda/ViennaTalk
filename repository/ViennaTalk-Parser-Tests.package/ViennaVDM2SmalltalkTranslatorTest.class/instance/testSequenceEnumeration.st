tests-expressions
testSequenceEnumeration
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '[1, 3, 5]')) equals: #(1 3 5) asOrderedCollection