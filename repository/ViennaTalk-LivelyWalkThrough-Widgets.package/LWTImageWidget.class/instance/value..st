accessing
value: aString
	path ~= aString
		ifTrue: [ 
			path := aString.
			form := [ ImageReadWriter formFromFileNamed: path ]
				on: Error
				do: [ :ex | nil ].
			self changed.
			self event: #changed ]