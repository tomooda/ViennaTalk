event handling
handlesMouseDown: anEvent
	self
		allMorphsDo: [ :m | 
			(m ~~ self and: [ (m bounds insetBy: self edgePrecision) containsPoint: anEvent position ])
				ifTrue: [ ^ false ] ].
	^ super handlesMouseDown: anEvent