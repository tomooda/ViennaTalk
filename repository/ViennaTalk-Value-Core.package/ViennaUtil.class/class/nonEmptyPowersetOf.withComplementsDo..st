private
nonEmptyPowersetOf: anArray withComplementsDo: aBlock
	1 to: (1 << anArray size) - 2 do: [ :index | 
		| array1 array2 |
		array1 := (Array new: anArray size) writeStream.
		array2 := (Array new: anArray size) writeStream.
		1 to: anArray size do: [ :bit | 
			((index bitAt: bit) = 0
				ifTrue: [ array1 ]
				ifFalse: [ array2 ]) nextPut: (anArray at: bit) ].
		aBlock value: array1 contents value: array2 contents ]