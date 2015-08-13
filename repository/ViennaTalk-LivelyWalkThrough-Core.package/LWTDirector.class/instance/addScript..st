accessing-scripts
addScript: aLWTLivetalkScript
	^ (scripts at: aLWTLivetalkScript widgetName ifAbsentPut: [ Dictionary new ])
		at: aLWTLivetalkScript event
		put: aLWTLivetalkScript