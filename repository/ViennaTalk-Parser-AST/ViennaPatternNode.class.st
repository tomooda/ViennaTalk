Class {
	#name : #ViennaPatternNode,
	#superclass : #ViennaNode,
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
