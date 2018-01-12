accessing
basePath
	[ basePath isNil or: [ basePath isDirectory not ] ]
		whileTrue: [ basePath := self requestBasePath ].
	^ basePath