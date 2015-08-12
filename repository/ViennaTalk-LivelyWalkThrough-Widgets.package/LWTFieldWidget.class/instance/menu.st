menus
menu
	| menu |
	menu := super menu.
	menu add: 'change text font' translated target: self selector: #changeTextFont.
	self showsDiagram
		ifTrue: [ 
			menu
				add: 'change diagram font' translated target: self selector: #changeDiagramFont;
				add: 'change diagram color' translated target: self selector: #changeDiagramColor;
				add: 'hide diagram' translated target: self selector: #hideDiagram ]
		ifFalse: [ menu add: 'show diagram' translated target: self selector: #showDiagram ].
	^ menu