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
