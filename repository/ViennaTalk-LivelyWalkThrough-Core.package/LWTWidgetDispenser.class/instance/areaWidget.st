accessing
areaWidget
	^ areaWidget
		ifNil: [ 
			areaWidget := LWTMouseSensor area
				freeze;
				name: 'Area';
				extent: 80 @ 80;
				yourself ]