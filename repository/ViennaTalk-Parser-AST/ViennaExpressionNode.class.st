Class {
	#name : #ViennaExpressionNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaExpressionNode class >> isAbstract [

	^ self = ViennaExpressionNode
]

{ #category : #private }
ViennaExpressionNode >> boundIdentifiersInto: aSet [
]

{ #category : #testing }
ViennaExpressionNode >> isViennaExpressionNode [
	^ true
]
