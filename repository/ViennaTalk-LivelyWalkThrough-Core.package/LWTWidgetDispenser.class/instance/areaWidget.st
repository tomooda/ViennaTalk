accessing
areaWidget
	^ areaWidget
		ifNil: [ 
			areaWidget := LWTMouseSensor area
				freeze;
				name: 'Area';
				nameColor: Color black;
				nameFont:
						(self nameFontForWidgets);
				extent: 80 @ 80;
				yourself ]