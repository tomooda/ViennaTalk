operations
changeNameColor
	| dialog |
	dialog := ColorSelectorDialogWindow new
		title: 'Choose a color for name';
		selectedColor: self nameColor.
	self openModal: dialog.
	dialog cancelled
		ifFalse: [ self nameColor: dialog selectedColor ]