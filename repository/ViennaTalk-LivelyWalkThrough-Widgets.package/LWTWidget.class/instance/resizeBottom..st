private
resizeBottom: aMouseEvent
	| handle |
	handle := HandleMorph new forEachPointDo: [ :newPoint | self bounds: (self topLeft corner: self right @ newPoint y) ].
	aMouseEvent hand attachMorph: handle.
	handle startStepping