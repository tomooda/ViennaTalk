event handling
doubleClick: aMouseEvent
	point := aMouseEvent position.
	self event: #doubleClicked