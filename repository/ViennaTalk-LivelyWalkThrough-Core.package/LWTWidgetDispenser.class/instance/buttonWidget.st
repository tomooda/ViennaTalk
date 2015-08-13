accessing
buttonWidget
	^ buttonWidget
		ifNil: [ 
			buttonWidget := LWTMouseSensor button
				freeze;
				name: 'Button';
				yourself ]