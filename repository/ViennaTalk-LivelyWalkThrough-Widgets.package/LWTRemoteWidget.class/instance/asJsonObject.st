json
asJsonObject
	^ super asJsonObject
		at: 'url' put: self url;
		yourself