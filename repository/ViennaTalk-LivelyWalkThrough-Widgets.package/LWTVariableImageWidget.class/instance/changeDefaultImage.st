operations
changeDefaultImage
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: nil
		preview: #image)
		ifNotNil: [ :filename | 
			[ forms at: nil put: (Form fromFileNamed: filename fullName) ]
				on: Error
				do: [ :ex |  ].
			self updateImage ]