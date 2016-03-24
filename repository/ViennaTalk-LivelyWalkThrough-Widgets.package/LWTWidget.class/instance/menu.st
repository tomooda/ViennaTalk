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
		add: 'move to front end' translated target: self selector: #moveFrontEnd;
		add: 'move front' translated target: self selector: #moveFront;
		add: 'move back' translated target: self selector: #moveBack;
		add: 'move to back end' translated target: self selector: #moveBackEnd;
		addLine;
		add: 'name' subMenu: self nameMenu yourself.
	^ menu