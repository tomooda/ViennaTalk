menus
menu
	| menu |
	menu := super menu.
	menu
		add: 'change color' translated target: self selector: #changeColor;
		add: 'border' translated
			subMenu:
				(MenuMorph new
						defaultTarget: self;
						add: 'change border color' translated target: self selector: #changeBorderColor;
						add: 'no border' translated target: self selector: #noBorder;
						add: 'thin' translated target: self selector: #thinBorder;
						add: 'thick' translated target: self selector: #thickBorder;
						yourself);
		yourself.
	^ menu