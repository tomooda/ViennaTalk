event handling
handleMouseDown: aMouseEvent
	aMouseEvent hand waitForClicksOrDrag: self event: aMouseEvent.
	^ super handleMouseDown: aMouseEvent