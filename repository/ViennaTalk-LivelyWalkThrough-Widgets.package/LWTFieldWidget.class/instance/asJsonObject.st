json
asJsonObject
	^ super asJsonObject
		at: 'contents' put: contents;
		at: 'textFont' put: (self fontToJsonObject: self textFont);
		at: 'showsDiagram' put: self showsDiagram;
		at: 'type' put: type;
		yourself