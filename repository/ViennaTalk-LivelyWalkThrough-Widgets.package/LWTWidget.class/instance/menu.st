menus
menu
	| menu |
	menu := MenuMorph new
		defaultTarget: self;
		add: 'change name' translated target: self selector: #changeName;
		add: 'delete' translated target: self selector: #delete;
		add: 'duplicate' translated target: self selector: #duplicateAndPlace;
		addLine;
		add: 'change name font' translated target: self selector: #changeNameFont;
		add: 'change name color' translated target: self selector: #changeNameColor;
		yourself.
	^ menu