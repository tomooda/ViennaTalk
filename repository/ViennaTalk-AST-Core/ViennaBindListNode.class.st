Class {
	#name : #ViennaBindListNode,
	#superclass : #ViennaPatternBindNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaBindListNode >> boundIdentifiersDo: aBlock [

	self do: [ :bind | bind boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaBindListNode >> formatWith: aViennaAbstractFormatter [

	| binds |
	binds := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: ',' , ((aViennaAbstractFormatter anyNeedsIndent: binds)
				   ifTrue: [ String cr ]
				   ifFalse: [ String space ])
		  withAll: binds
]

{ #category : #private }
ViennaBindListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :bind | bind freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaBindListNode >> isViennaBindListNode [

	^ true
]

{ #category : #accessing }
ViennaBindListNode >> label [

	^ 'BindList'
]

{ #category : #private }
ViennaBindListNode >> listDelimiter [

	^ ', '
]

{ #category : #private }
ViennaBindListNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]

{ #category : #private }
ViennaBindListNode >> maximalType: aViennaType [

	self do: [ :bind | bind maximalType: aViennaType ].
	super maximalType: self maximalType
]
