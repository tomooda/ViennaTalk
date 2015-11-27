tests-literals
testCharacterLiteral
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''A''')) equals: $A.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\''''')) equals: $'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\\''')) equals: $\.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\n'''))
		equals: Character lf.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\101''')) equals: $A.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\x41''')) equals: $A.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\u0041''')) equals: $A