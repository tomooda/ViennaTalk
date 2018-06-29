Class {
	#name : #ViennaUnicode,
	#superclass : #Unicode,
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #testing }
ViennaUnicode class >> isDigit: aCharacter [
	^ aCharacter charCode between: $0 charCode and: $9 charCode
]

{ #category : #testing }
ViennaUnicode class >> isFollowingLetter: aCharacter [
	| code codeCategory |
	(#($$ $_ $') includes: aCharacter)
		ifTrue: [ ^ true ].
	code := aCharacter charCode.
	codeCategory := GeneralCategory at: code + 1 ifAbsent: [  ].
	^ code < 16r100
		ifTrue: [ 
			{Ll.
			Lm.
			Lo.
			Lt.
			Lu.
			Nd} includes: codeCategory ]
		ifFalse: [ 
			({Cc.
			Zl.
			Zp.
			Zs.
			Cs.
			Cn} includes: codeCategory) not ]
]

{ #category : #testing }
ViennaUnicode class >> isHexadecimalDigit: aCharacter [
	^ (aCharacter charCode between: $0 charCode and: $9 charCode)
		or: [ 
			(aCharacter charCode between: $a charCode and: $f charCode)
				or: [ aCharacter charCode between: $A charCode and: $F charCode ] ]
]

{ #category : #testing }
ViennaUnicode class >> isInitialLetter: aCharacter [
	| code codeCategory |
	aCharacter = $$
		ifTrue: [ ^ true ].
	code := aCharacter charCode.
	codeCategory := GeneralCategory at: code + 1 ifAbsent: [  ].
	^ code < 16r100
		ifTrue: [ 
			{Ll.
			Lm.
			Lo.
			Lt.
			Lu} includes: codeCategory ]
		ifFalse: [ 
			({Cc.
			Zl.
			Zp.
			Zs.
			Cs.
			Cn.
			Nd.
			Pc} includes: codeCategory) not ]
]

{ #category : #testing }
ViennaUnicode class >> isOctalDigit: aCharacter [
	^ aCharacter charCode between: $0 charCode and: $7 charCode
]
