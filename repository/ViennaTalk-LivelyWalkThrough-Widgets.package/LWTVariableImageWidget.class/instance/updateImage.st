updating
updateImage
	form := (map at: value ifAbsent: [ path ])
		ifNotNil: [ :imagePath | 
			Transcript cr; show: 'displaying ', imagePath.
			[ ImageReadWriter formFromFileNamed: imagePath ]
				on: Error
				do: [ :ex | nil ] ].
	self changed