formatting-types
basicType: aViennaNode
	| type |
	type := aViennaNode first.
	type = 'bool'
		ifTrue: [ ^ self bool ].
	type = 'nat'
		ifTrue: [ ^ self nat ].
	type = 'nat1'
		ifTrue: [ ^ self nat1 ].
	type = 'int'
		ifTrue: [ ^ self int ].
	type = 'real'
		ifTrue: [ ^ self real ].
	^ type