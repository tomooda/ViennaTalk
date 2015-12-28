parsing
parse: aString
	| translator |
	translator := super parse: aString.
	translator isPetitFailure
		ifFalse: [ translator source: aString ].
	^ translator