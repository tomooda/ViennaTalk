utilities
translateStatement: aString ifError: aBlock
	| ast |
	ast := ViennaVDMParser new statement end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self new generate: ast