accessing
padWidget
	^ padWidget
		ifNil: [ 
			padWidget := LWTMouseSensor pad
				freeze;
				name: 'MousePad';
				extent: 80 @ 80;
				yourself ]