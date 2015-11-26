tests-expressions
testLocalfunction
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'let inc:int->int inc(x)==x+1 in inc(2)')) equals: 3