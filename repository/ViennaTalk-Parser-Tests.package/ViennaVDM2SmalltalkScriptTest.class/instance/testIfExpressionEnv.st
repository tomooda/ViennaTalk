tests-code generation-expressions
testIfExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'if x > 0 then <positive> elseif x = 0 then <zero> else <negative>'.
	self deny: node isPetitFailure.
	self assert: node label = 'IfExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: {('x' -> '1')} asDictionary))
		equals: #positive.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: {('x' -> '0')} asDictionary))
		equals: #zero.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: {('x' -> '-1')} asDictionary))
		equals: #negative