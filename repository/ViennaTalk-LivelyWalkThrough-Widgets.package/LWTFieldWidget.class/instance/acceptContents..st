accessing
acceptContents: aStringOrText
	| oldContents |
	oldContents := contents.
	contents := aStringOrText asString.
	contents ~= oldContents ifTrue: [ self event: #changed ].
	^ true