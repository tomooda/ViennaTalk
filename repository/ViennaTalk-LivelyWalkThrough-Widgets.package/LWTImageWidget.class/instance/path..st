private
path: aString
	path := aString.
	form := [ ImageReadWriter formFromFileNamed: path ]
		on: Error
		do: [ :ex | nil ].
	self changed