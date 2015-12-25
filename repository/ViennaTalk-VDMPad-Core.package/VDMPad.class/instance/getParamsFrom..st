private
getParamsFrom: aZnRequest
	^ (aZnRequest contentType main = 'application' and: [ aZnRequest contentType sub asLowercase = 'json' ])
		ifTrue: [ NeoJSONReader fromString: aZnRequest entity ]
		ifFalse: [ aZnRequest mergedFields ]