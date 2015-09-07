accessing
variableImageWidget
	^ variableImageWidget
		ifNil: [ 
			variableImageWidget := LWTImageWidget new
				freeze;
				name: 'VariableImage';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				extent: 80 @ 80;
				value: 'Pharo.png';
				yourself ]