events
when: eventSymbol add: anActionSymbol beforeIndex: anInteger
	(eventActionDict at: eventSymbol ifAbsentPut: [ OrderedCollection new ])
		in: [ :actions | actions add: anActionSymbol beforeIndex: (anInteger ifNil: [ actions size + 1 ]) ]