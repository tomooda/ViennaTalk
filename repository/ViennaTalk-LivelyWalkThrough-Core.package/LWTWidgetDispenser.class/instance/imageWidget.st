accessing
imageWidget
	^ imageWidget
		ifNil: [ 
			imageWidget := LWTImageWidget new
				freeze;
				name: 'Image';
				extent: 80 @ 80;
				value: 'Pharo.png'
				yourself ]