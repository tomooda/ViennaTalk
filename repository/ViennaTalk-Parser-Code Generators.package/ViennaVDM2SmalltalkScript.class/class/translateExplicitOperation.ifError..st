utilities
translateExplicitOperation: aString ifError: aBlock
	| ast |
	ast := ViennaVDMParser new explicitOperationDefinition end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self new generate: ast