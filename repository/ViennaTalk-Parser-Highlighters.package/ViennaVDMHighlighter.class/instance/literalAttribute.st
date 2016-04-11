accessing
literalAttribute
	^ literalAttribute ifNil: [ literalAttribute := TextColor color: Color yellow muchDarker ]