event handling
handleMouseMove: aMouseEvent
	self moveable = true
		ifTrue: [ 
			(self edgeName: aMouseEvent position)
				ifEmpty: [ ActiveHand showTemporaryCursor: Cursor normal ]
				ifNotEmpty: [ :edge | ActiveHand showTemporaryCursor: (Cursor perform: ('resize' , edge) asSymbol) ] ]