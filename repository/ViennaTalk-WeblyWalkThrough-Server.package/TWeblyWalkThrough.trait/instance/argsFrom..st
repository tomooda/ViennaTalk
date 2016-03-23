request handling
argsFrom: aZnRequest
	| args |
	args := Array new.
	aZnRequest method = 'get'
		ifTrue: [ 
			args := aZnRequest uri query
				ifNil: [ #() ]
				ifNotNil: [ :query | query values collect: [ :arg | self translateFromJson: arg ] ] ].
	aZnRequest method = 'post'
		ifTrue: [ 
			(aZnRequest contentType main = 'application' and: [ aZnRequest contentType sub asLowercase = 'json' ])
				ifTrue: [ 
					args := NeoJSONReader fromString: aZnRequest entity contents.
					args isArray
						ifTrue: [ args := args collect: [ :arg | self translateFromJson: (NeoJSONWriter toString: arg) ] ]
						ifFalse: [ args := self translateFromJson: aZnRequest entity contents ] ]
				ifFalse: [ 
					(aZnRequest contentType main = 'application' and: [ aZnRequest contentType sub asLowercase = 'x-www-form-urlencoded' ])
						ifTrue: [ args := aZnRequest entity fields values collect: [ :arg | self translateFromJson: arg ] ] ] ].
	^ args