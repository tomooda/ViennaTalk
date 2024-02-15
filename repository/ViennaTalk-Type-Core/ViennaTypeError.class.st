Class {
	#name : #ViennaTypeError,
	#superclass : #Error,
	#instVars : [
		'node'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #signaling }
ViennaTypeError class >> on: aViennaExpressionNode signal: aString [

	^ self new
		  node: aViennaExpressionNode;
		  signal: aString
]

{ #category : #signaling }
ViennaTypeError class >> signalOn: aViennaNode [

	^ self new
		  node: aViennaNode;
		  signal
]

{ #category : #accessing }
ViennaTypeError >> node [

	^ node
]

{ #category : #accessing }
ViennaTypeError >> node: aViennaNode [

	node := aViennaNode
]
