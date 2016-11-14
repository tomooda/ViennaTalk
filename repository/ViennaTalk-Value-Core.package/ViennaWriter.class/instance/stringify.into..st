stringifying
stringify: anObject into: aStream
	specials
		at: anObject class name
		ifPresent: [ :printer | 
			^ printer isSymbol
				ifTrue: [ self perform: printer with: anObject with: aStream ]
				ifFalse: [ printer value: anObject value: aStream ] ].
	anObject isCharacter
		ifTrue: [ ^ self stringifyToChar: anObject into: aStream ].
	anObject isArray
		ifTrue: [ ^ self stringifyToTuple: anObject into: aStream ].
	anObject isDictionary
		ifTrue: [ ^ self stringifyToMap: anObject into: aStream ].
	anObject isString
		ifTrue: [ ^ self stringifyToString: anObject into: aStream ].
	anObject isCollection
		ifTrue: [ ^ anObject isSequenceable
				ifTrue: [ self stringifyToSeq: anObject into: aStream ]
				ifFalse: [ ^ self stringifyToSet: anObject into: aStream ] ].
	anObject isViennaComposite
		ifTrue: [ self stringifyToComposite: anObject into: aStream ].
	^ (anObject respondsTo: #viennaStringOn:)
		ifTrue: [ anObject viennaStringOn: aStream ]
		ifFalse: [ self error: 'Failed to stringify' ]