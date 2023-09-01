Class {
	#name : #ViennaPatternNode,
	#superclass : #ViennaPatternBindNode,
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

{ #category : #accessing }
ViennaPatternNode >> pattern [

	^ self
]
