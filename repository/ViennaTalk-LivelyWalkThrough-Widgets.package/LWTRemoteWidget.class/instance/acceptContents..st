accessing
acceptContents: aStringOrText
	| oldContents |
	oldContents := contents.
	super acceptContents: aStringOrText.
	oldContents ~= aStringOrText asString trim
		ifTrue: [ ZnEasy put: self url asUrl data: (ZnEntity text: aStringOrText) ].
	^ true