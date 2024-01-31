Class {
	#name : #ViennaTypeError,
	#superclass : #Exception,
	#instVars : [
		'expressionNode'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #signaling }
ViennaTypeError class >> on: aViennaExpressionNode signal: aString [

	^ self new
		  expressionNode: aViennaExpressionNode;
		  signal: aString
]

{ #category : #accessing }
ViennaTypeError >> expressionNode [

	^ expressionNode
]

{ #category : #accessing }
ViennaTypeError >> expressionNode: anObject [

	expressionNode := anObject
]
