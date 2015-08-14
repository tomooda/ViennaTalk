accessing
fieldWidget
	^ fieldWidget
		ifNil: [ 
			fieldWidget := LWTFieldWidget new
				freeze;
				name: 'Field';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				yourself ]