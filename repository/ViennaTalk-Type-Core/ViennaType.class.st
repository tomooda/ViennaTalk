Class {
	#name : #ViennaType,
	#superclass : #Object,
	#type : #variable,
	#category : 'ViennaTalk-Type-Core'
}

{ #category : #'instance creation' }
ViennaType class >> compose: aString of: anArray [
	^ ViennaCompositeType constructor: aString withAll: anArray
]

{ #category : #'instance creation' }
ViennaType class >> int [
	^ ViennaIntType current
]

{ #category : #'instance creation' }
ViennaType class >> option: aViennaType [
	^ ViennaOptionType with: aViennaType
]

{ #category : #accessing }
ViennaType class >> precedence [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
ViennaType class >> product: anArrayOfViennaType [
	^ ViennaProductType withAll: anArrayOfViennaType
]

{ #category : #'instance creation' }
ViennaType class >> quote: aString [
	^ ViennaQuoteType with: aString asSymbol
]

{ #category : #'instance creation' }
ViennaType class >> real [
	^ ViennaRealType current
]

{ #category : #'instance creation' }
ViennaType class >> union: anArrayOfViennaType [
	^ ViennaUnionType withAll: anArrayOfViennaType
]

{ #category : #arithmetic }
ViennaType >> * aViennaType [
	^ ViennaProductType with: self with: aViennaType
]

{ #category : #enumerating }
ViennaType >> allSatisfy: aBlock [
	self
		do: [ :value | 
			(aBlock value: value)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #enumerating }
ViennaType >> anySatisfy: aBlock [
	self
		do: [ :value | 
			(aBlock value: value)
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #enumerating }
ViennaType >> collect: aBlock [
	^ Array new: 4 streamContents: [ :stream | self do: [ :value | stream nextPut: (aBlock value: value) ] ]
]

{ #category : #enumerating }
ViennaType >> detect: aBlock [
	self
		do: [ :value | 
			(aBlock value: value)
				ifTrue: [ ^ value ] ].
	^ NotFound signal
]

{ #category : #enumerating }
ViennaType >> do: aBlock [
	^ self subclassResponsibility
]

{ #category : #testing }
ViennaType >> includes: anObject [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaType >> name [
	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaType >> nameInPrecedence: anInteger [
	^ self class precedence < anInteger
		ifTrue: [ '(' , self name , ')' ]
		ifFalse: [ self name ]
]

{ #category : #arithmetic }
ViennaType >> optional [
	^ ViennaOptionType with: self
]

{ #category : #printing }
ViennaType >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #enumerating }
ViennaType >> select: aBlock [
	^ Array
		new: 4
		streamContents: [ :stream | 
			self
				do: [ :value | 
					(aBlock value: value)
						ifTrue: [ stream nextPut: value ] ] ]
]

{ #category : #accessing }
ViennaType >> size [
	| count |
	count := 0.
	self do: [ :value | count := count + 1 ].
	^ count
]

{ #category : #arithmetic }
ViennaType >> | aViennaType [
	^ ViennaUnionType with: self with: aViennaType
]
