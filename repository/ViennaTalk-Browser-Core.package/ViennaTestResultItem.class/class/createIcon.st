accessing
createIcon
	| form |
	form := Form extent: self iconExtent depth: 32.
	form getCanvas
		fillColor: Color transparent;
		fillOval: (0 @ 0 extent: self iconExtent)
			color: self iconColor
			borderWidth: 1
			borderColor: self iconColor darker.
	^ form