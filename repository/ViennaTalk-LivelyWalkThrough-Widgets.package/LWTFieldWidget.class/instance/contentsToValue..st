validating
contentsToValue: aString
	type = #string
		ifTrue: [ ^ ViennaWriter new stringify: aString ].
	^ aString