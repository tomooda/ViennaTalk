accessing
name: aString
	World
		findDeepSubmorphThat: [ :m | (m isKindOf: LWTWidget) and: [ m name = aString ] ]
		ifAbsent: [ ^ self name: aString ].
	UIManager default inform: 'The name "' , aString , '" is already used.'