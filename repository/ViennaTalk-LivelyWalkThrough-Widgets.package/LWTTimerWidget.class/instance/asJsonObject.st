json
asJsonObject
	^ super asJsonObject
		at: 'rawValue' put: self rawValue;
		at: 'stepTime' put: self stepTime;
		yourself