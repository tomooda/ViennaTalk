request handling
handleRequest: aZnRequest
	| path method args result evalString resultJson |
	path := aZnRequest uri isSlash
		ifTrue: [ ^ self frontPage ]
		ifFalse: [ aZnRequest uri segments ].
	path size > 2
		ifTrue: [ ^ ZnResponse notFound: aZnRequest url ].
	path = #('favicon.ico')
		ifTrue: [ ^ ZnResponse notFount: aZnRequest url ].
	args := Array new.
	method := aZnRequest method asLowercase.
	method = 'get'
		ifTrue: [ 
			args := aZnRequest uri query
				ifNil: [ #() ]
				ifNotNil: [ :query | query values collect: [ :arg | translator jsonToVdmString: arg ] ] ].
	method = 'post'
		ifTrue: [ 
			(aZnRequest contentType main = 'application' and: [ aZnRequest contentType sub asLowercase = 'json' ])
				ifTrue: [ args := Array with: (translator jsonToVdmString: aZnRequest entity) ].
			(aZnRequest contentType main = 'application'
				and: [ aZnRequest contentType sub asLowercase = 'x-www-form-urlencoded' ])
				ifTrue: [ args := aZnRequest entity fields values collect: [ :arg | translator jsonToVdmString: arg ] ] ].
	evalString := ('`' join: path) , '(' , (', ' join: args) , ')'.
	result := self
		plainEvaluate: evalString
		ifError: [ :msg | ^ ZnResponse serverError: evalString , String cr , String cr , msg ].
	resultJson := translator vdmToJsonString: result.
	resultJson isPetitFailure
		ifTrue: [ ^ ZnResponse serverError: resultJson printString , ' : ' , result asString ].
	^ ZnResponse
		ok:
			((ZnStringEntity type: ZnMimeType applicationJson)
				string: resultJson;
				yourself)