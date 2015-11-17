parsing
parseCompositeOn: aStream
	(aStream nextMatchAll: 'mk_')
		ifFalse: [ ^ self error: 'expected mk_' ].
	(aStream upTo: $() trimRight
		in: [ :typeName | 
			| args |
			args := Array new writeStream.
			aStream skipSeparators.
			aStream peek = $)
				ifFalse: [ 
					[ 
					args nextPut: (self parseOn: aStream).
					aStream skipSeparators.
					aStream peek = $, ] whileTrue: [ aStream next ] ].
			(aStream nextMatchFor: $))
				ifFalse: [ ^ self error: 'expected ")"' ].
			args := args contents.
			typeName isEmpty
				ifTrue: [ 
					args size < 2
						ifTrue: [ ^ self error: 'A tuple must have more than one args.' ].
					^ specials at: #'' ifPresent: [ :block | block value: args ] ifAbsent: [ args ] ].
			(typeName = 'token' and: [ args size ~= 1 ])
				ifTrue: [ ^ self error: 'A token must have only one arg.' ].
			^ specials
				at: typeName asSymbol
				ifPresent: [ :block | block valueWithArguments: args ]
				ifAbsent: [ ViennaComposite type: typeName withAll: args ] ]