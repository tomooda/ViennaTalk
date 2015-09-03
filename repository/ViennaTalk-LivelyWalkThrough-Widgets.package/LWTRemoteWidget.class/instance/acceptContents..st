accessing
acceptContents: aString
	super acceptContents: aString.
	ZnEasy put: self url asUrl data: (ZnEntity text: aString).
	^ true