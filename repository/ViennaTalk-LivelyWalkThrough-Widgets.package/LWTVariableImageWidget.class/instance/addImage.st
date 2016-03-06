operations
addImage
	| key |
	[ 
	key := UIManager default request: 'Enter a value to map from'.
	key ifNil: [ ^ self ].
	(forms includesKey: key) and: [ (UIManager proceed: key , ' is already defined. Do you want to overwite it?') not ] ]
		whileTrue.
	(LivelyWalkThrough
		fileOpen: 'Select an image file'
		extensions: #('png' 'jpg' 'jpeg')
		path: nil
		preview: #image)
		ifNotNil: [ :filename | 
			[forms at: key put: (Form fromFileNamed: filename fullName)] on: Error do: [:ex | ].
			self updateImage ]