geometry
layoutFrameForTextPane
	^ self showsDiagram
		ifTrue: [ 
			(LayoutFrame fractions: (0 @ 0 corner: 1 @ 0))
				leftOffset: 3;
				rightOffset: -3;
				topOffset: self textOffset y;
				bottomOffset: self textOffset y + self textExtent y;
				yourself ]
		ifFalse: [ 
			(LayoutFrame fractions: (0 @ 0 corner: 1 @ 1))
				leftOffset: 3;
				rightOffset: -3;
				topOffset: self textOffset y;
				bottomOffset: -3;
				yourself ]