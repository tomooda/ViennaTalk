json
asJsonObject
	^ super asJsonObject
		at: 'base64Forms' put: self base64Forms;
		at: '_rawValue' put: self rawValue;
		yourself