operations
changeColor
	| dialog |
	dialog := ColorSelectorDialogWindow new
		title: 'Choose a color for the sensor';
		selectedColor: self color.
	self openModal: dialog.
	dialog cancelled
		ifFalse: [ self color: dialog selectedColor ]