event handling
handleMouseMove: aMouseEvent
	point := aMouseEvent position.
	self event: #moved.
	^ super handleMouseMove: aMouseEvent