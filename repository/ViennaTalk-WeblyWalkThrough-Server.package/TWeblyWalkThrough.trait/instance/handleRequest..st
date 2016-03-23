request handling
handleRequest: aZnRequest
	| path method |
	path := aZnRequest uri isSlash
		ifTrue: [ ^ self frontPage ]
		ifFalse: [ aZnRequest uri segments ].
	path size > 2
		ifTrue: [ ^ self responseNotFound: aZnRequest url ].
	path = #('favicon.ico')
		ifTrue: [ ^ self responseNotFound: aZnRequest url ].
	method := aZnRequest method asLowercase.
	method = 'options'
		ifTrue: [ 
			^ self
				responseOk:
					((ZnStringEntity type: ZnMimeType textPlain)
						string: '';
						yourself) ].
	^ self handleApi: aZnRequest