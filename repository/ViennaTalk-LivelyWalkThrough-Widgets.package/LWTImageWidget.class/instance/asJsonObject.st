json
asJsonObject
	^ super asJsonObject
		at: 'base64Form' put: self base64Form;
		yourself