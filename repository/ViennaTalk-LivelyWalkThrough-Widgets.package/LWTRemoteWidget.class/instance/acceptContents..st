accessing
acceptContents: aStringOrText
	| oldContents |
	oldContents := contents.
	super acceptContents: aStringOrText.
	ZnEasy put: self url asUrl data: (ZnEntity text: aStringOrText).
	^ true