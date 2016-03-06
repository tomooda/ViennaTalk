updating
updateImage
	form := forms at: value ifAbsent: [ forms at: nil ifAbsent: [ nil ] ].
	self changed