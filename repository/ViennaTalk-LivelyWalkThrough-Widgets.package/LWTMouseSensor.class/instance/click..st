event handling
click: aMouseEvent
	point := aMouseEvent position.
	self event: #clicked