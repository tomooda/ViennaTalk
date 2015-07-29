private
readCharOn: aStream
	| char |
	char := aStream next.
	char = $\
		ifFalse: [ ^ char ].
	char := aStream next.
	char = $r
		ifTrue: [ ^ Character lf ].
	char = $n
		ifTrue: [ ^ Character cr ].
	char = $t
		ifTrue: [ ^ Character tab ].
	char = $f
		ifTrue: [ ^ Character newPage ].
	char = $e
		ifTrue: [ ^ Character escape ].
	char = $a
		ifTrue: [ ^ Character codePoint: 10 ].
	char = $b
		ifTrue: [ ^ Character backspace ].
	char = $x
		ifTrue: [ ^ Character codePoint: (Integer readFrom: (aStream next: 2) base: 16) ].
	char = $u
		ifTrue: [ ^ Character codePoint: (Integer readFrom: (aStream next: 4) base: 16) ].
	char = $c
		ifTrue: [ ^ Character codePoint: aStream next asciiValue - $a asciiValue ].
	char isDigit
		ifTrue: [ 
			^ Character
				codePoint:
					(char asciiValue - $0 asciiValue) * 64 + ((aStream next asciiValue - $0 asciiValue) * 8)
						+ (aStream next asciiValue - $0 asciiValue) ].
	char = $"
		ifTrue: [ ^ $" ].
	char = $'
		ifTrue: [ ^ $' ].
	^ self error: 'unexpected escape char: ' , char asString