json
pointToJsonObject: aPoint
	^ Dictionary new
		at: 'storeString' put: aPoint storeString;
		yourself