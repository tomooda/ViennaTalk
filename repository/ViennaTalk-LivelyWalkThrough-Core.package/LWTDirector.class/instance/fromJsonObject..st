json
fromJsonObject: aDictionary
	self widgetsFromJsonObject: (aDictionary at: 'widgets').
	self specification: (aDictionary at: 'specification').
	self scriptsFromJsonObject: (aDictionary at: 'scripts').
	self frames: (aDictionary at: 'frames').
	self urlPrefix: (aDictionary at: 'urlPrefix')