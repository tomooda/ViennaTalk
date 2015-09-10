accessing
value: aString
	path ~= aString
		ifTrue: [ 
			path := aString.
			form := [ ImageReadWriter formFromFileNamed: path ]
				on: Error
				do: [ :ex | nil ].
			self changed.
			self event: #assigned.
			self event: #changed ]
		ifFalse: [ self event: #assigned ]