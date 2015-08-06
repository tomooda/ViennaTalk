private
edgeName: aPoint
	| edge |
	edge := ''.
	(self left - aPoint x) abs < self edgePrecision
		ifTrue: [ edge := 'Left' , edge ]
		ifFalse: [ 
			(self right - aPoint x) abs < self edgePrecision
				ifTrue: [ edge := 'Right' , edge ] ].
	(self top - aPoint y) abs < self edgePrecision
		ifTrue: [ edge := 'Top' , edge ]
		ifFalse: [ 
			(self bottom - aPoint y) abs < self edgePrecision
				ifTrue: [ edge := 'Bottom' , edge ] ].
	^ edge