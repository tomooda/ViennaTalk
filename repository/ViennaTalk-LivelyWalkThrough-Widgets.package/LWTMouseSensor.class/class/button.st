instance creation
button
	^ self new
		basename: 'Button';
		extent: 200 @ 30;
		color: Color lightGray;
		nameColor: Color black;
		borderColor: Color darkGray;
		thickBorder;
		yourself