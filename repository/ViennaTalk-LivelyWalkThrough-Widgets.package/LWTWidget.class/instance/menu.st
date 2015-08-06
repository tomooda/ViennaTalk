menus
menu
	| menu |
	menu := MenuMorph new
		defaultTarget: self;
		add: 'change name font' translated target: self selector: #changeNameFont;
		add: 'change name color' translated target: self selector: #changeNameColor;
		yourself.
	^ menu