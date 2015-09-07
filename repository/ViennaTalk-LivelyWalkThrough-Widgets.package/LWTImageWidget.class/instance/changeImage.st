operations
changeImage
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: path
		preview: #image) ifNotNil: [ :filename | self value: filename fullName ]