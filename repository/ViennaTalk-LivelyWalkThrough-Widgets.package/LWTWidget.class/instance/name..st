accessing
name: aString
	World
		findDeepSubmorphThat: [ :m | (m isKindOf: LWTWidget) and: [ m ~~ self and: [ m name = aString ] ] ]
		ifAbsent: [ 
			name := aString.
			self changed.
			^ self ].
	self changeName