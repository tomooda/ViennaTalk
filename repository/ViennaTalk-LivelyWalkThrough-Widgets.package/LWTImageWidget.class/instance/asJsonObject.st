json
asJsonObject
	^ super asJsonObject
		at: 'path' put: self path;
		yourself