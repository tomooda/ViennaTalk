private
resizeLeft: aMouseEvent
	| handle |
	handle := HandleMorph new forEachPointDo: [ :newPoint | self bounds: (newPoint x @ self top corner: self bottomRight) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping