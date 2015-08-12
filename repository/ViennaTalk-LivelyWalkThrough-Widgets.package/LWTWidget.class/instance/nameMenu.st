menus
nameMenu
	| menu |
	menu := MenuMorph new.
	menu
		defaultTarget: self;
		add: 'change name' translated target: self selector: #changeName.
	self showsName = true
		ifTrue: [ 
			menu
				add: 'hide' translated target: self selector: #hideName;
				add: 'change name font' translated target: self selector: #changeNameFont;
				add: 'change name color' translated target: self selector: #changeNameColor ]
		ifFalse: [ menu add: 'show' translated target: self selector: #showName ].
	^ menu