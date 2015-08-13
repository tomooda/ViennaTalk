instance creation
area
	^ self new
		basename: 'Area';
		extent: 100 @ 100;
		color: Color transparent;
		borderColor: Color gray;
		thinBorder;
		yourself