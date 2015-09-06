json
asJsonObject
	^ Dictionary new
		at: 'widgets' put: self widgetsToJsonObject;
		at: 'specification' put: self specification;
		at: 'scripts' put: self scriptsToJsonObject;
		at: 'frames' put: self frames;
		at: 'urlPrefix' put: self urlPrefix;
		yourself