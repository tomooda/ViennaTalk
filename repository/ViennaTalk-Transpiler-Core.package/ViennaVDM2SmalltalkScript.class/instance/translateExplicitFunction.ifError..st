utilities
translateExplicitFunction: aString ifError: aBlock
	| ast |
	ast := ViennaVDMParser new explicitFunctionDefinition end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self generate: ast