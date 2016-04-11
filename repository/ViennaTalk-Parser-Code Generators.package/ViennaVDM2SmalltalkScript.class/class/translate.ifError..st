utilities
translate: aString ifError: aBlock
	| ast |
	ast := ViennaVDMParser new parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self new generate: ast