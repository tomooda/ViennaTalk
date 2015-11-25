private
powersetOf: anArray do: aBlock
	0 to: (1 << anArray size) - 1 do: [ :index | 
		aBlock
			value:
				(Array
					new: anArray size
					streamContents: [ :stream | 
						1 to: anArray size do: [ :bit | 
							(index bitAt: bit) = 0
								ifTrue: [ stream nextPut: (anArray at: bit) ] ] ]) ]