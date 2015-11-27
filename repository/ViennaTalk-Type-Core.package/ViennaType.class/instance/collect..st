enumerating
collect: aBlock
	^ Array new: 4 streamContents: [ :stream | self do: [ :value | stream nextPut: (aBlock value: value) ] ]