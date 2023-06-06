Class {
	#name : #ViennaPatternNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaPatternNode class >> isAbstract [

	^ self = ViennaPatternNode
]

{ #category : #testing }
ViennaPatternNode >> isViennaPatternNode [

	^ true
]
