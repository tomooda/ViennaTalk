accessing
areaWidget
	^ areaWidget ifNil: [ areaWidget := LWTMouseSensor area ]