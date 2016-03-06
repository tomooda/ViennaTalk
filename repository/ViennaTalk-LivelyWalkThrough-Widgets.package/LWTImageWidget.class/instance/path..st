private
path: aString
	form := [ ImageReadWriter formFromFileNamed: aString ]
		on: Error
		do: [ :ex | nil ].
	self changed