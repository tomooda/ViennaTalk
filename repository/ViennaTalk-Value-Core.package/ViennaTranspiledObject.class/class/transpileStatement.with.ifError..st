transpiling
transpileStatement: aString with: transpiler ifError: errorBlock
	| ast |
	ast := ViennaVDMParser new expression end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ errorBlock cull: ast message ].
	^ transpiler
		defaultEnv: viennaEnv;
		generate: ast