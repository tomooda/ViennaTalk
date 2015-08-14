accessing
imageWidget
	^ imageWidget
		ifNil: [ 
			imageWidget := LWTImageWidget new
				freeze;
				name: 'Image';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				extent: 80 @ 80;
				value: 'Pharo.png';
				yourself ]