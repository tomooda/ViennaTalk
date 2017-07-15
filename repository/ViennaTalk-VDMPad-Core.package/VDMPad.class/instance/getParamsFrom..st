private
getParamsFrom: aZnRequest
	^ (aZnRequest contentType notNil
		and: [ aZnRequest contentType main = 'application' and: [ aZnRequest contentType sub asLowercase = 'json' ] ])
		ifTrue: [ NeoJSONReader fromString: aZnRequest entity ]
		ifFalse: [ aZnRequest mergedFields ]