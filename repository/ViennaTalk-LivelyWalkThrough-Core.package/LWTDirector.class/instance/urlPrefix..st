accessing
urlPrefix: aString
	urlPrefix ~= aString
		ifTrue: [ 
			self releaseHandlers.
			urlPrefix := aString.
			urlPrefix ifNotEmpty: [ self class server delegate map: urlPrefix to: self ].
			self changed: #urlPrefix ]