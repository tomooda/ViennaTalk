enumerating
basicDo: aBlock
	| values |
	values := Array new: 1024 streamContents: [ :stream | basetype do: [ :v | stream nextPut: v ] ].
	values powerDo: [ :array | aBlock value: array asSet ]