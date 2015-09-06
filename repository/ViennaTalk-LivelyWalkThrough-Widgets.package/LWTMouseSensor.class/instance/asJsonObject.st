json
asJsonObject
	^ super asJsonObject
		at: 'basename' put: self basename;
		at: 'point' put: (self pointToJsonObject: self point);
		at: 'color' put: (self colorToJsonObject: self color);
		at: 'borderColor' put: (self colorToJsonObject: self borderColor);
		at: 'borderWidth' put: self borderWidth;
		yourself