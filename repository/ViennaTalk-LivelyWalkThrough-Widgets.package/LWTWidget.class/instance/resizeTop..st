private
resizeTop: aMouseEvent
	| handle |
	handle := HandleMorph new
		forEachPointDo: [ :newPoint | self bounds: (self left @ newPoint y corner: self bottomRight) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping