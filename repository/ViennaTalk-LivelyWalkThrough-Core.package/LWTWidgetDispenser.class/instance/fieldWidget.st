accessing
fieldWidget
	^ fieldWidget
		ifNil: [ 
			fieldWidget := LWTFieldWidget new
				freeze;
				name: 'Field';
				yourself ]