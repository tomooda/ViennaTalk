Class {
	#name : #ViennaSequenceEnumerationNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
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

{ #category : #accessing }
ViennaSequenceEnumerationNode >> label [

	^ 'SequenceEnumeration'
]
