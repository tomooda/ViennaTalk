notifying
notify: aString at: anInteger in: aStream
	| pos |
	pos := self selectionInterval notEmpty
		ifTrue: [ self startIndex + anInteger - 1 ]
		ifFalse: [ anInteger ].
	self insertAndSelect: aString at: (pos max: 1)