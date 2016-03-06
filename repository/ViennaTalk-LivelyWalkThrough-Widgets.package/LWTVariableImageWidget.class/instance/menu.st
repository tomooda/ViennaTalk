menu
menu
	| menu |
	menu := super menu.
	menu addLine.
	forms
		keysDo: [ :key | 
			menu
				add: key
				subMenu:
					(MenuMorph new
						add: 'change...' translated
							target: self
							selector: #changeImageAt:
							argument: key;
						add: 'remove' translated
							target: self
							selector: #removeImageAt:
							argument: key;
						yourself) ].
	menu
		add: 'DEFAULT'
		subMenu:
			(MenuMorph new
				add: 'change...' translated target: self selector: #changeDefaultImage;
				add: 'remove' translated target: self selector: #removeDefaultImage;
				yourself).
	menu add: 'add mapping' target: self selector: #addImage.
	^ menu