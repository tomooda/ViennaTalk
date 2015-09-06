json
colorToJsonObject: aColor
	^ Dictionary new
		at: 'storeString' put: aColor storeString;
		yourself