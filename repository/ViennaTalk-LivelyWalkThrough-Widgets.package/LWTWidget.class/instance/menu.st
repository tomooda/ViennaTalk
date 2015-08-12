menus
menu
	| menu |
	menu := MenuMorph new
		addTitle: self name;
		defaultTarget: self;
		add: 'delete' translated target: self selector: #delete;
		add: 'duplicate' translated target: self selector: #duplicateAndPlace;
		add:
				(self moveable
						ifTrue: [ 'fix position' translated ]
						ifFalse: [ 'make moveable' ])
			target: self
			selector: #toggleMoveable;
		addLine;
		add: 'name' subMenu: self nameMenu yourself.
	^ menu