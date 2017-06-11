utilities
defineLazyMethodNamed: selector initializer: initializer in: aClass protocol: protocol node: aViennaNode
	^ self
		defineMethod:
			selector , String cr , '^ ' , selector , ' ifNil: [' , initializer , '.' , selector , ']'
		in: aClass
		protocol: protocol
		node: aViennaNode