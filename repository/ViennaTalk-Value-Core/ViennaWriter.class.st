Class {
	#name : #ViennaWriter,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'specials'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #accessing }
ViennaWriter >> at: aClassNameSymbol put: aTwoArgumentBlockOrSelector [
	specials at: aClassNameSymbol put: aTwoArgumentBlockOrSelector
]

{ #category : #'initialize-release' }
ViennaWriter >> initialize [
	super initialize.
	specials := Dictionary new
]

{ #category : #accessing }
ViennaWriter >> remove: aClassNameSymbol [
	specials removeKey: aClassNameSymbol ifAbsent: [  ]
]

{ #category : #stringifying }
ViennaWriter >> stringify: anObject [
	^ String streamContents: [ :stream | self stringify: anObject into: stream ]
]

{ #category : #stringifying }
ViennaWriter >> stringify: anObject into: aStream [
	specials
		at: anObject class name
		ifPresent: [ :printer | 
			^ printer isSymbol
				ifTrue: [ self perform: printer with: anObject with: aStream ]
				ifFalse: [ printer value: anObject value: aStream ] ].
	(#(true false nil) includes: anObject)
		ifTrue: [ ^ anObject printOn: aStream ].
	anObject isNumber
		ifTrue: [ ^ self stringifyToNumber: anObject into: aStream ].
	anObject isCharacter
		ifTrue: [ ^ self stringifyToChar: anObject into: aStream ].
	anObject isArray
		ifTrue: [ ^ self stringifyToTuple: anObject into: aStream ].
	anObject isDictionary
		ifTrue: [ ^ self stringifyToMap: anObject into: aStream ].
	anObject isSymbol
		ifTrue: [ ^ self stringifyToQuote: anObject into: aStream ].
	anObject isString
		ifTrue: [ ^ self stringifyToString: anObject into: aStream ].
	anObject isCollection
		ifTrue: [ ^ anObject isSequenceable
				ifTrue: [ self stringifyToSeq: anObject into: aStream ]
				ifFalse: [ ^ self stringifyToSet: anObject into: aStream ] ].
	^ anObject viennaStringOn: aStream
]

{ #category : #stringifying }
ViennaWriter >> stringifyToChar: aCharacter into: aStream [
	aStream nextPut: $'.
	self writeChar: aCharacter into: aStream.
	aStream nextPut: $'
]

{ #category : #stringifying }
ViennaWriter >> stringifyToMap: aDictionary into: aStream [
	aStream nextPut: ${.
	aDictionary
		ifEmpty: [ aStream nextPutAll: '|->' ]
		ifNotEmpty: [ 
			aDictionary associations
				do: [ :assoc | 
					self stringify: assoc key into: aStream.
					aStream nextPutAll: '|->'.
					self stringify: assoc value into: aStream ]
				separatedBy: [ aStream nextPut: $, ] ].
	aStream nextPut: $}
]

{ #category : #stringifying }
ViennaWriter >> stringifyToNumber: aNumber into: aStream [
	aNumber printOn: aStream
]

{ #category : #stringifying }
ViennaWriter >> stringifyToQuote: aSymbol into: aStream [
	(aSymbol allSatisfy: #isLetter)
		ifFalse: [ ^ self error: 'Invalid character in a VDM quote ' ].
	aStream
		nextPut: $<;
		nextPutAll: aSymbol;
		nextPut: $>
]

{ #category : #stringifying }
ViennaWriter >> stringifyToSeq: anOrderedCollection into: aStream [
	aStream nextPut: $[.
	anOrderedCollection do: [ :obj | self stringify: obj into: aStream ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $]
]

{ #category : #stringifying }
ViennaWriter >> stringifyToSet: aSet into: aStream [
	aStream nextPut: ${.
	aSet do: [ :obj | self stringify: obj into: aStream ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $}
]

{ #category : #stringifying }
ViennaWriter >> stringifyToString: aString into: aStream [
	aStream nextPut: $".
	aString do: [ :char | self writeChar: char into: aStream ].
	aStream nextPut: $"
]

{ #category : #stringifying }
ViennaWriter >> stringifyToTuple: anArray into: aStream [
	anArray size < 2 ifTrue: [ ^ self error: 'A tuple must have more than one argument.' ].
	 aStream nextPutAll: 'mk_('.
	anArray do: [ :obj | self stringify: obj into: aStream ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $)
]

{ #category : #private }
ViennaWriter >> writeChar: aCharacter into: aStream [
	aCharacter codePoint
		in: [ :code | 
			code = 8
				ifTrue: [ ^ aStream nextPutAll: '\b' ].
			code = 9
				ifTrue: [ ^ aStream nextPutAll: '\t' ].
			code = 10
				ifTrue: [ ^ aStream nextPutAll: '\r' ].
			code = 12
				ifTrue: [ ^ aStream nextPutAll: '\f' ].
			code = 13
				ifTrue: [ ^ aStream nextPutAll: '\n' ].
			code = 34
				ifTrue: [ ^ aStream nextPutAll: '\"' ].
			code = 39
				ifTrue: [ ^ aStream nextPutAll: '\''' ].
			code = 92
				ifTrue: [ ^ aStream nextPutAll: '\\' ].
			code < 32
				ifTrue: [ 
					aStream nextPutAll: '\x'.
					^ code printOn: aStream base: 16 nDigits: 2 ].
			code > 126
				ifTrue: [ 
					aStream nextPutAll: '\u'.
					^ code printOn: aStream base: 16 nDigits: 4 ] ].
	aStream nextPut: aCharacter
]
