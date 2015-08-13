operations
changeImage
	(UIManager default chooseFullFileNameMatching: nil label: 'Select an image file')
		ifNotNil: [ :filename | self value: filename asString ]