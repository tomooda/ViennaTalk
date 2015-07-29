parsing
parseSetOrMapOn: aStream
	| first |
	(aStream nextMatchAll: '{')
		ifFalse: [ ^ self error: 'expected {' ].
	aStream skipSeparators.
	aStream peek = $}
		ifTrue: [ 
			aStream next.
			^ specials at: #set ifPresent: [ :block | block value: Array new ] ifAbsent: [ Set new ] ].
	aStream peek = $|
		ifTrue: [ 
			(aStream nextMatchAll: '|->')
				ifFalse: [ ^ self error: 'Expected |->' ].
			aStream skipSeparators.
			(aStream nextMatchAll: '}')
				ifFalse: [ ^ self error: 'Expected }' ].
			^ specials at: #map ifPresent: [ :block | block value: Array new ] ifAbsent: [ Dictionary new ] ].
	first := self parseOn: aStream.
	aStream skipSeparators.
	aStream peek = $}
		ifTrue: [ ^ specials at: #set ifPresent: [ :block | block value: (Array with: first) ] ifAbsent: [ Set with: first ] ].
	aStream peek = $,
		ifTrue: [ ^ self parseSetOn: aStream with: first ].
	aStream peek = $|
		ifTrue: [ ^ self parseMapOn: aStream with: first ].
	^ self error: 'Expected , or |->'