operations
addImage
	| key |
	[ 
	key := UIManager default request: 'Enter a value to map from'.
	key ifNil: [ ^ self ].
	(map includesKey: key) and: [ (UIManager proceed: key , ' is already defined. Do you want to overwite it?') not ] ]
		whileTrue.
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: path
		preview: #image)
		ifNotNil: [ :filename | 
			map at: key put: filename fullName.
			self updateImage ]