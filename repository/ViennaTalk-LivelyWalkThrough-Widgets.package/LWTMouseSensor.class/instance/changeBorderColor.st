operations
changeBorderColor
	| dialog |
	dialog := ColorSelectorDialogWindow new
		title: 'Choose a border color for the sensor';
		selectedColor: self borderColor.
	self openModal: dialog.
	dialog cancelled
		ifFalse: [ self borderColor: dialog selectedColor ]