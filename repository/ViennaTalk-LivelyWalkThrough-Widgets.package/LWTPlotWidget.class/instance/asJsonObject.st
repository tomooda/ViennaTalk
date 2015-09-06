json
asJsonObject
	^ super asJsonObject
		at: 'rawData' put: self rawData;
		at: 'textFont' put: (self fontToJsonObject: self textFont);
		at: 'lineWidth' put: self lineWidth;
		at: 'dotRadius' put: self dotRadius;
		yourself