operations
changeImageAt: key
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: nil
		preview: #image)
		ifNotNil: [ :filename | 
			[ forms at: key put: (Form fromFileNamed: filename fullName) ]
				on: Error
				do: [ :ex |  ].
			self updateImage ]