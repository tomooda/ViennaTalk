Class {
	#name : #ViennaBasicTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaBasicTypeNode class >> any [

	^ self identifier: 'any'
]

{ #category : #'instance creation' }
ViennaBasicTypeNode class >> identifier: aString [

	^ (self new: 1)
		  identifier: aString;
		  yourself
]

{ #category : #converting }
ViennaBasicTypeNode >> asMaximalViennaType [

	| identifier |
	identifier := self identifier.
	identifier = 'int' ifTrue: [ ^ ViennaType int ].
	identifier = 'nat' ifTrue: [ ^ ViennaType nat ].
	identifier = 'nat1' ifTrue: [ ^ ViennaType nat1 ].
	identifier = 'real' ifTrue: [ ^ ViennaType real ].
	identifier = 'rat' ifTrue: [ ^ ViennaType rat ].
	identifier = 'char' ifTrue: [ ^ ViennaType char ].
	identifier = 'bool' ifTrue: [ ^ ViennaType bool ].
	identifier = 'any' ifTrue: [ ^ ViennaType any ].
	identifier = 'token' ifTrue: [ ^ ViennaType token ].
	^ self error: 'Unknown basic type'
]

{ #category : #'pretty printing' }
ViennaBasicTypeNode >> formatWith: aViennaAbstractFormatter [

	| type |
	type := self identifier.
	type = 'bool'
		ifTrue: [ ^ aViennaAbstractFormatter bool ].
	type = 'nat'
		ifTrue: [ ^ aViennaAbstractFormatter nat ].
	type = 'nat1'
		ifTrue: [ ^ aViennaAbstractFormatter nat1 ].
	type = 'int'
		ifTrue: [ ^ aViennaAbstractFormatter int ].
	type = 'real'
		ifTrue: [ ^ aViennaAbstractFormatter real ].
	type = 'any'
		ifTrue: [ ^ aViennaAbstractFormatter anyType ].
	^ type
]

{ #category : #private }
ViennaBasicTypeNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : #accessing }
ViennaBasicTypeNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaBasicTypeNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaBasicTypeNode >> isViennaBasicTypeNode [

	^ true
]

{ #category : #accessing }
ViennaBasicTypeNode >> label [

	^ 'BasicType'
]
