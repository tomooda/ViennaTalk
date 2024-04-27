Class {
	#name : #ViennaMatchValueNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
	^ self expression isViennaSymbolicLiteralNode
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

{ #category : #typechecking }
ViennaMatchValueNode >> maximalType [

	^ self expression typecheck
]

{ #category : #typechecking }
ViennaMatchValueNode >> maximalType: aViennaType [

	super maximalType: self maximalType
]
