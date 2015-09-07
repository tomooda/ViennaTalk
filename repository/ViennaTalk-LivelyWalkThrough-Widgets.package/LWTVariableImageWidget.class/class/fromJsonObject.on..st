json
fromJsonObject: aDictionary on: aLWTDirector
	^ (super fromJsonObject: aDictionary on: aLWTDirector)
		rawValue: (aDictionary at: '_rawValue');
		yourself