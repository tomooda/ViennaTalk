accessing
value: aString
	aString asInteger
		ifNotNil: [ :i | 
			| oldValue |
			oldValue := value.
			value := i asString.
			self event: #assigned.
			oldValue ~= value
				ifTrue: [ self event: #changed ].
			self changed ]