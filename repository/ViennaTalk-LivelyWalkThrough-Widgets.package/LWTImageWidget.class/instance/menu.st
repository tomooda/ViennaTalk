menu
menu
	| menu |
	menu := super menu.
	menu
		add: 'change image' translated target: self selector: #changeImage;
		add: 'remove image' translated target: self selector: #noImage;
		yourself.
	^ menu