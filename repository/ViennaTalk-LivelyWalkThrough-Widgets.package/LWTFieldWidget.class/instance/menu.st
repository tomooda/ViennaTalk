menus
menu
	| menu |
	menu := super menu.
	menu add: 'change text font' translated target: self selector: #changeTextFont.
	menu
		add: 'type' translated
		subMenu:
			(MenuMorph new
				defaultTarget: self;
				addToggle: 'number' translated
					target: self
					selector: #changeNumberType
					getStateSelector: #isNumberType;
				addToggle: 'string' translated
					target: self
					selector: #changeStringType
					getStateSelector: #isStringType;
				addToggle: 'vdm' translated
					target: self
					selector: #changeVDMType
					getStateSelector: #isVDMType;
				addToggle: 'any' translated
					target: self
					selector: #changeAnyType
					getStateSelector: #isAnyType;
				yourself).
	self showsDiagram
		ifTrue: [ 
			menu
				add: 'change diagram font' translated target: self selector: #changeDiagramFont;
				add: 'change diagram color' translated target: self selector: #changeDiagramColor;
				add: 'hide diagram' translated target: self selector: #hideDiagram ]
		ifFalse: [ menu add: 'show diagram' translated target: self selector: #showDiagram ].
	^ menu