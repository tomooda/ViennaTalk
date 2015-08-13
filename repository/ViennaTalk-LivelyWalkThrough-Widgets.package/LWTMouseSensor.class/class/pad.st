instance creation
pad
	^ self new
		basename: 'MousePad';
		extent: 200 @ 200;
		color: (Color lightGray alpha: 0.5);
		borderColor: Color gray;
		thinBorder;
		yourself