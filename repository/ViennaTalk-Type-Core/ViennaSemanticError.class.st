Class {
	#name : 'ViennaSemanticError',
	#superclass : 'Error',
	#instVars : [
		'node'
	],
	#category : 'ViennaTalk-Type-Core',
	#package : 'ViennaTalk-Type-Core'
}

{ #category : 'signaling' }
ViennaSemanticError class >> on: aViennaExpressionNode signal: aString [

	^ self new
		  node: aViennaExpressionNode;
		  signal: aString
]

{ #category : 'signaling' }
ViennaSemanticError class >> signalOn: aViennaNode [

	^ self new
		  node: aViennaNode;
		  signal
]

{ #category : 'accessing' }
ViennaSemanticError >> node [

	^ node
]

{ #category : 'accessing' }
ViennaSemanticError >> node: aViennaNode [

	node := aViennaNode
]
