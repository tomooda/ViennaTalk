accessing
typeAttribute
	^ typeAttribute ifNil: [ typeAttribute := TextColor color: Color cyan muchDarker ]