Class {
	#name : #ViennaSetEnumerationNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaSetEnumerationNode class >> expressionList: aViennaExpressionListNode [

	^ (self new: 1)
		  expressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : #accessing }
ViennaSetEnumerationNode >> expressionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaSetEnumerationNode >> expressionList: aViennaExpressionListNode [

	self at: 1 put: aViennaExpressionListNode
]

{ #category : #'pretty printing' }
ViennaSetEnumerationNode >> formatWith: aViennaAbstractFormatter [

	| elements |
	elements := aViennaAbstractFormatter formatAll: self first.
	^ '{'
	  ,
	  (aViennaAbstractFormatter formatEnumerate: elements ifEmpty: [ '' ])
	  , '}'
]

{ #category : #private }
ViennaSetEnumerationNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expressionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaSetEnumerationNode >> isViennaSetEnumerationNode [

	^ true
]

{ #category : #accessing }
ViennaSetEnumerationNode >> label [

	^ 'SetEnumeration'
]

{ #category : #typechecking }
ViennaSetEnumerationNode >> maximalType [

	| basetype |
	basetype := ViennaType unit.
	self expressionList do: [ :expr |
		basetype := basetype + expr typecheck ].
	^ self expressionList
		  ifEmpty: [ basetype set ]
		  ifNotEmpty: [ basetype set1 ]
]

{ #category : #typechecking }
ViennaSetEnumerationNode >> maximalType: aViennaType [

	| basetype |
	basetype := ViennaType unit.
	aViennaType isAnyType
		ifTrue: [ basetype := ViennaType any ]
		ifFalse: [
			aViennaType
				possibleTypesSuchThat: #isSetType
				do: [ :setType | basetype := basetype + setType basetype ] ].
	self do: [ :exp | exp maximalType: basetype ].
	super maximalType: aViennaType
]
