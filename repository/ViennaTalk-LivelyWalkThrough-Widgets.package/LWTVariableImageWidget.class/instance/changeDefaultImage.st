operations
changeDefaultImage
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: path
		preview: #image)
		ifNotNil: [ :filename | 
			path := filename fullName.
			self updateImage ]