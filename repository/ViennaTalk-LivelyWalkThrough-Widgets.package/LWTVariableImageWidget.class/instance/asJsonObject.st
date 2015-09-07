json
asJsonObject
	^ super asJsonObject
		at: 'path' put: self path;
		at: 'map' put: self map;
		at: '_rawValue' put: self rawValue;
		yourself