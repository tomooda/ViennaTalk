Class {
	#name : #ViennaSequenceEnumerationNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaSequenceEnumerationNode class >> expressionList: aViennaExpressionListNode [

	^ (self new: 1)
		  expressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : #accessing }
ViennaSequenceEnumerationNode >> expressionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaSequenceEnumerationNode >> expressionList: aViennaExpressionListNode [

	self at: 1 put: aViennaExpressionListNode
]

{ #category : #'pretty printing' }
ViennaSequenceEnumerationNode >> formatWith: aViennaAbstractFormatter [

	| elements |
	elements := aViennaAbstractFormatter formatAll: self expressionList.
	^ '['
	  ,
	  (aViennaAbstractFormatter formatEnumerate: elements ifEmpty: [ '' ])
	  , ']'
]

{ #category : #private }
ViennaSequenceEnumerationNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expressionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaSequenceEnumerationNode >> isViennaSequenceEnumerationNode [

	^ true
]

{ #category : #accessing }
ViennaSequenceEnumerationNode >> label [

	^ 'SequenceEnumeration'
]

{ #category : #typechecking }
ViennaSequenceEnumerationNode >> maximalType [

	| basetype |
	basetype := ViennaType unit.
	self expressionList do: [ :expr |
		basetype := basetype + expr typecheck ].
	^ self expressionList
		  ifEmpty: [ basetype seq ]
		  ifNotEmpty: [ basetype seq1 ]
]

{ #category : #typechecking }
ViennaSequenceEnumerationNode >> maximalType: aViennaType [

	| basetype |
	aViennaType isAnyType
		ifTrue: [ basetype := ViennaType any ]
		ifFalse: [
			basetype := ViennaType unit.
			aViennaType
				possibleTypesSuchThat: #isSeqType
				do: [ :seqType | basetype := basetype + seqType basetype ] ].
	self do: [ :exp | exp maximalType: basetype ].
	super maximalType: aViennaType
]
