utilities
formatSource: aString ifError: errorBlock
	| ast |
	ast := ViennaVDMParser new parse: aString asString.
	ast isPetitFailure
		ifTrue: [ ^ errorBlock value ].
	^ self format: ast