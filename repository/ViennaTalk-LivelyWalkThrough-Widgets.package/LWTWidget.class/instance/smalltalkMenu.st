menus
smalltalkMenu
	| menu |
	menu := MenuMorph new
		addTitle: self name;
		defaultTarget: self;
		add: 'inspect' translated target: self selector: #inspect;
		yourself.
	^ menu