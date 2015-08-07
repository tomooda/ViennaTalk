menus
menu
	| menu |
	menu := MenuMorph new.
	menu
		defaultTarget: self;
		add: 'change name' translated target: self selector: #changeName;
		add: 'delete' translated target: self selector: #delete;
		add: 'duplicate' translated target: self selector: #duplicateAndPlace;
		addLine.
	self showsName
		ifTrue: [ 
			menu
				add: 'change name font' translated target: self selector: #changeNameFont;
				add: 'change name color' translated target: self selector: #changeNameColor;
				add: 'hide name' translated target: self selector: #hideName ]
		ifFalse: [ menu add: 'show name' translated target: self selector: #showName ].
	menu
		addLine;
		add: 'change text font' translated target: self selector: #changeTextFont;
		addLine.
	self showsDiagram
		ifTrue: [ 
			menu
				add: 'change diagram font' translated target: self selector: #changeDiagramFont;
				add: 'change diagram color' translated target: self selector: #changeDiagramColor;
				add: 'hide diagram' translated target: self selector: #hideDiagram ]
		ifFalse: [ menu add: 'show diagram' translated target: self selector: #showDiagram ].
	^ menu