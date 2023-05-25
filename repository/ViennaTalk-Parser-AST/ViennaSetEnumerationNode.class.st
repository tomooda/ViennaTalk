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

{ #category : #testing }
ViennaSetEnumerationNode >> isViennaSetEnumerationNode [

	^ true
]

{ #category : #accessing }
ViennaSetEnumerationNode >> label [

	^ 'SetEnumeration'
]
