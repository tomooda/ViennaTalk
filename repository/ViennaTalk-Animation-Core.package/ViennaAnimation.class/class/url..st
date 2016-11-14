instance creation
url: aStringOrUrl
	^ self new
		engine: (ViennaClient on: aStringOrUrl);
		yourself