accessing
requestBasePath
	^ (UIManager default
		chooseDirectory: 'Choose a VDM spec directory'
		from: self class defaultBasePath) ifNotNil: [ :dir | DefaultBasePath := dir ]