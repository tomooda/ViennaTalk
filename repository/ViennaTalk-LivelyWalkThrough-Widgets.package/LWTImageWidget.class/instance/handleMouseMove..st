event handling
handleMouseMove: aMouseEvent
	self event: #moved.
	^ super handleMouseMove: aMouseEvent