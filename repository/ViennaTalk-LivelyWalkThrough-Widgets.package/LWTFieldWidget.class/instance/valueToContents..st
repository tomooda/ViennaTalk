validating
valueToContents: aString
	type = #string
		ifTrue: [ ^ ViennaReader new parseStringOn: aString trim readStream ].
	^ aString