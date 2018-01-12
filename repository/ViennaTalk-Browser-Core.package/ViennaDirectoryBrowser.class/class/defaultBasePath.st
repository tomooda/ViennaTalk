accessing
defaultBasePath
	(DefaultBasePath isNil or: [ DefaultBasePath isDirectory not ])
		ifTrue: [ DefaultBasePath := FileLocator desktop ].
	^ DefaultBasePath