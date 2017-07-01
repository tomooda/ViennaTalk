utilities
translateExpression: aString ifError: aBlock
	| ast |
	ast := ViennaVDMParser new expression end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self generate: ast