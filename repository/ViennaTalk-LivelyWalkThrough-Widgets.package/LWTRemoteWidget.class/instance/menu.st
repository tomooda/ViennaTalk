menu
menu
	| menu |
	menu := super menu.
	menu
		add: 'url...' translated target: self selector: #changeUrl.
	^ menu