private
resizeTopRight: aMouseEvent
	| handle |
	handle := HandleMorph new
		forEachPointDo: [ :newPoint | self bounds: (self left @ newPoint y corner: newPoint x @ self bottom) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping