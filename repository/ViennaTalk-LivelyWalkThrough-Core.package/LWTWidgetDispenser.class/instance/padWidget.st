accessing
padWidget
	^ padWidget
		ifNil: [ 
			padWidget := LWTMouseSensor pad
				freeze;
				name: 'MousePad';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				extent: 80 @ 80;
				yourself ]