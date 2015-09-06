json
asJsonObject
	^ Dictionary new
		at: '_class' put: self class name asString;
		at: '_relativePosition' put: (self pointToJsonObject: self position - self owner position);
		at: 'extent' put: (self pointToJsonObject: self extent);
		at: 'name' put: self name;
		at: 'nameFont' put: (self fontToJsonObject: self nameFont);
		at: 'nameColor' put: (self colorToJsonObject: self nameColor);
		at: 'moveable' put: self moveable;
		at: 'showsName' put: self showsName;
		yourself