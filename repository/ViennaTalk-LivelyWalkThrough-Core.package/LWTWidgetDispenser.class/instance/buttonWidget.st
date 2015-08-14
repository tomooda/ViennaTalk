accessing
buttonWidget
	^ buttonWidget
		ifNil: [ 
			buttonWidget := LWTMouseSensor button
				freeze;
				name: 'Button';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				yourself ]