operations
menu
	| menu |
	menu := super menu.
	menu
		add: 'change color' translated target: self selector: #changeColor;
		add: 'line' translated
			subMenu:
				(MenuMorph new
						defaultTarget: self;
						add: 'no line' translated target: self selector: #noLine;
						add: 'thin line' translated target: self selector: #thinLine;
						add: 'thick line' translated target: self selector: #thickLine;
						yourself);
		add: 'dot' translated
			subMenu:
				(MenuMorph new
						defaultTarget: self;
						add: 'no dot' translated target: self selector: #noDot;
						add: 'small dot' translated target: self selector: #smallDot;
						add: 'big dot' translated target: self selector: #bigDot;
						yourself);
		yourself.
	^ menu