accessing
name: aString
	self director
		ifNotNil: [ :director | 
			director
				findDeepSubmorphThat: [ :m | (m isKindOf: LWTWidget) and: [ m ~~ self and: [ m name = aString ] ] ]
				ifAbsent: [ 
					name := aString.
					self changed.
					^ self ].
			self changeName ]
		ifNil: [ 
			name := aString.
			self changed ]