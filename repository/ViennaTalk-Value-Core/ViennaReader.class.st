Class {
	#name : #ViennaReader,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'specials'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #'initialize-release' }
ViennaReader >> initialize [
	super initialize.
	specials := Dictionary new
]

{ #category : #parsing }
ViennaReader >> parse: aString [
	^ self parseOn: aString readStream
]

{ #category : #parsing }
ViennaReader >> parseCharOn: aStream [
	| char |
	(aStream nextMatchAll: '''')
		ifFalse: [ ^ self error: 'expected ''' ].
	char := self readCharOn: aStream.
	(aStream nextMatchAll: '''')
		ifFalse: [ ^ self error: 'expected ''' ].
	^ specials at: #char ifPresent: [ :block | block value: char ] ifAbsent: [ char ]
]

{ #category : #parsing }
ViennaReader >> parseCompositeOn: aStream [
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
				ifAbsent: [ VDMComposite type: typeName withAll: args ] ]
]

{ #category : #parsing }
ViennaReader >> parseFalseOn: aStream [
	(aStream nextMatchAll: 'false')
		ifFalse: [ ^ self error: 'expected false' ].
	^ specials at: #false ifAbsent: [ false ]
]

{ #category : #parsing }
ViennaReader >> parseMapOn: aStream with: first [
	| args |
	(aStream nextMatchAll: '|->')
		ifFalse: [ ^ self error: 'expected |->' ].
	aStream skipSeparators.
	args := Array new writeStream.
	args nextPut: first -> (self parseOn: aStream).
	[ 
	aStream skipSeparators.
	aStream peek = $, ]
		whileTrue: [ 
			| key value |
			aStream next.
			key := self parseOn: aStream.
			aStream skipSeparators.
			(aStream nextMatchAll: '|->')
				ifFalse: [ ^ self error: 'expected |->' ].
			value := self parseOn: aStream.
			args nextPut: key -> value ].
	(aStream nextMatchFor: $})
		ifFalse: [ ^ self error: 'expected }' ].
	args := args contents.
	^ specials at: #set ifPresent: [ :block | block value: args ] ifAbsent: [ args asDictionary ]
]

{ #category : #parsing }
ViennaReader >> parseNilOn: aStream [
	(aStream nextMatchAll: 'nil')
		ifFalse: [ ^ self error: 'expected nil' ].
	^ specials at: #nil ifAbsent: [ nil ]
]

{ #category : #parsing }
ViennaReader >> parseNumberOn: aStream [
	^ Number readFrom: aStream ifFail: [ self error: 'number expected' ]
]

{ #category : #parsing }
ViennaReader >> parseOn: aStream [
	aStream skipSeparatorsAndPeekNext
		in: [ :char | 
			char = $n
				ifTrue: [ ^ self parseNilOn: aStream ].
			char = $t
				ifTrue: [ ^ self parseTrueOn: aStream ].
			char = $f
				ifTrue: [ ^ self parseFalseOn: aStream ].
			char = $m
				ifTrue: [ ^ self parseCompositeOn: aStream ].
			char = ${
				ifTrue: [ ^ self parseSetOrMapOn: aStream ].
			char = $[
				ifTrue: [ ^ self parseSeqOn: aStream ].
			char = $<
				ifTrue: [ ^ self parseQuoteOn: aStream ].
			char = $'
				ifTrue: [ ^ self parseCharOn: aStream ].
			char = $"
				ifTrue: [ ^ self parseStringOn: aStream ].
			(char = $- or: [ char isDigit ])
				ifTrue: [ ^ self parseNumberOn: aStream ].
			^ self error: 'Unexpected character in VDM value: ' , aStream upToEnd ]
]

{ #category : #parsing }
ViennaReader >> parseQuoteOn: aStream [
	| quote |
	(aStream nextMatchAll: '<')
		ifFalse: [ ^ self error: 'expected <' ].
	quote := aStream upTo: $>.
	(quote allSatisfy: #isLetter)
		ifFalse: [ ^ self error: 'Invalid char in quote' ].
	^ specials at: #<> ifPresent: [ :block | block value: quote ] ifAbsent: [ quote asSymbol ]
]

{ #category : #parsing }
ViennaReader >> parseSeqOn: aStream [
	| args |
	(aStream nextMatchAll: '[')
		ifFalse: [ ^ self error: 'expected [' ].
	args := Array new writeStream.
	aStream skipSeparators.
	aStream peek = $]
		ifFalse: [ 
			[ 
			args nextPut: (self parseOn: aStream).
			aStream skipSeparators.
			aStream peek = $, ] whileTrue: [ aStream next ] ].
	(aStream nextMatchFor: $])
		ifFalse: [ ^ self error: 'expected ]' ].
	args := args contents.
	^ specials at: #seq ifPresent: [ :block | block valueWithArguments: args ] ifAbsent: [ args asOrderedCollection ]
]

{ #category : #parsing }
ViennaReader >> parseSetOn: aStream with: first [
	| args |
	(aStream nextMatchAll: ',')
		ifFalse: [ ^ self error: 'expected ,' ].
	args := Array new writeStream.
	args nextPut: first.
	aStream skipSeparators.
	[ 
	args nextPut: (self parseOn: aStream).
	aStream skipSeparators.
	aStream peek = $, ] whileTrue: [ aStream next ].
	(aStream nextMatchFor: $})
		ifFalse: [ ^ self error: 'expected }' ].
	args := args contents.
	^ specials at: #set ifPresent: [ :block | block value: args ] ifAbsent: [ args asSet ]
]

{ #category : #parsing }
ViennaReader >> parseSetOrMapOn: aStream [
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
]

{ #category : #parsing }
ViennaReader >> parseStringOn: aStream [
	| string |
	(aStream nextMatchAll: '"')
		ifFalse: [ ^ self error: 'expected "' ].
	string := String
		streamContents: [ :stream | [ aStream peek = $" ] whileFalse: [ stream nextPut: (self readCharOn: aStream) ] ].
	(aStream nextMatchAll: '"')
		ifFalse: [ ^ self error: 'expected "' ].
	^ specials at: #'seq of char' ifPresent: [ :block | block value: string ] ifAbsent: [ string ]
]

{ #category : #parsing }
ViennaReader >> parseTrueOn: aStream [
	(aStream nextMatchAll: 'true')
		ifFalse: [ ^ self error: 'expected true' ].
	^ specials at: #true ifAbsent: [ true ]
]

{ #category : #private }
ViennaReader >> readCharOn: aStream [
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
]

{ #category : #parsing }
ViennaReader >> skipCommentOn: aStream [
	(aStream nextMatchAll: '/*')
		ifFalse: [ ^ self error: 'expected /*' ].
	[ aStream atEnd ]
		whileFalse: [ 
			(aStream nextMatchAll: '*/')
				ifTrue: [ ^ self ].
			aStream next ].
	^ self error: 'unexpected EOF before */'
]

{ #category : #parsing }
ViennaReader >> skipLineCommentOn: aStream [
	(aStream nextMatchAll: '--')
		ifFalse: [ ^ self error: 'expected --' ].
	[ aStream atEnd ]
		whileFalse: [ 
			('\n\r' includes: aStream next)
				ifTrue: [ ^ self ] ]
]
