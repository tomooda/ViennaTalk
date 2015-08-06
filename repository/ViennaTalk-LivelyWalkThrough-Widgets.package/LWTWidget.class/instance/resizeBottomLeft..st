private
resizeBottomLeft: aMouseEvent
	| handle |
	handle := HandleMorph new
		forEachPointDo: [ :newPoint | self bounds: (newPoint x @ self top corner: self right @ newPoint y) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping