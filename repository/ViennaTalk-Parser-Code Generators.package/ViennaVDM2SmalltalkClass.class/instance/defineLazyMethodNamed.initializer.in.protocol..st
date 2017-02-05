utilities
defineLazyMethodNamed: selector initializer: initializer in: aClass protocol: protocol
	^ self
		defineMethod:
			selector , String cr , '^ ' , selector , ' ifNil: [' , initializer , '.'
				, selector , ']'
		in: aClass
		protocol: protocol