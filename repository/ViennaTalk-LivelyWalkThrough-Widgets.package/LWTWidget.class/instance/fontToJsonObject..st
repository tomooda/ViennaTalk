json
fontToJsonObject: aFont
	^ Dictionary new
		at: 'storeString' put: aFont storeString;
		at: 'onError' put: 'TextStyle default defaultFont';
		yourself