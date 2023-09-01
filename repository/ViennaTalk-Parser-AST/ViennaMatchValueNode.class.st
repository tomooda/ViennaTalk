Class {
	#name : #ViennaMatchValueNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaMatchValueNode class >> expression: aViennaExpressionNode [

	^ (self new: 1)
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #private }
ViennaMatchValueNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #accessing }
ViennaMatchValueNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaMatchValueNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaMatchValueNode >> formatWith: aViennaAbstractFormatter [

	| value |
	value := aViennaAbstractFormatter format: self expression.
	^ self first isViennaSymbolicLiteralNode
		  ifTrue: [ value ]
		  ifFalse: [ '(' , value , ')' ]
]

{ #category : #private }
ViennaMatchValueNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaMatchValueNode >> isViennaMatchValueNode [

	^ true
]

{ #category : #accessing }
ViennaMatchValueNode >> label [

	^ 'MatchValue'
]
