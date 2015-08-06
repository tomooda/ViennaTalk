private
resizeTopLeft: aMouseEvent
	| handle |
	handle := HandleMorph new forEachPointDo: [ :newPoint | self bounds: (newPoint corner: self bottomRight) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping