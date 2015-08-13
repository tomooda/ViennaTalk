accessing
fieldWidget
	^ fieldWidget
		ifNil: [ 
			LWTFieldWidget new
				name: 'FieldWidget';
				yourself ]