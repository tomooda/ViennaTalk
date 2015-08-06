private
resizeRight: aMouseEvent
	| handle |
	handle := HandleMorph new forEachPointDo: [ :newPoint | self bounds: (self topLeft corner: newPoint x @ self bottom) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping