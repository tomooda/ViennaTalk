Class {
	#name : #ViennaAbstractSyntaxNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaAbstractSyntaxNode class >> isAbstract [

	^ self = ViennaAbstractSyntaxNode
]

{ #category : #initialization }
ViennaAbstractSyntaxNode >> setLabel: aString [

	aString = self label ifFalse: [ self error: 'Label mismatch' ].
	label := aString
]
