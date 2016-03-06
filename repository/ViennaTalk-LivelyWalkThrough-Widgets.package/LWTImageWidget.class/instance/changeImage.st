operations
changeImage
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: nil
		preview: #image)
		ifNotNil: [ :filename | 
			[ form := Form fromFileNamed: filename fullName ]
				on: Error
				do: [ :ex |  ] ]