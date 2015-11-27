enumerating
select: aBlock
	^ Array
		new: 4
		streamContents: [ :stream | 
			self
				do: [ :value | 
					(aBlock value: value)
						ifTrue: [ stream nextPut: value ] ] ]