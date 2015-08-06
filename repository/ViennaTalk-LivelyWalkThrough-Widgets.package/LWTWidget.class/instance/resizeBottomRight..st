private
resizeBottomRight: aMouseEvent
	| handle |
	handle := HandleMorph new forEachPointDo: [ :newPoint | self bounds: (self topLeft corner: newPoint) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping