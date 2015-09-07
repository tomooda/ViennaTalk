operations
changeImageAt: key
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: path
		preview: #image)
		ifNotNil: [ :filename | 
			map at: key put: filename fullName.
			self updateImage ]