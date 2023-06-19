Class {
	#name : #ViennaBindNode,
	#superclass : #ViennaPatternBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaBindNode class >> isAbstract [

	^ self = ViennaBindNode
]

{ #category : #testing }
ViennaBindNode >> isViennaBindNode [

	^ true
]

{ #category : #accessing }
ViennaBindNode >> pattern [

	^ self at: 1
]

{ #category : #accessing }
ViennaBindNode >> pattern: aViennaPatternNode [

	self at: 1 put: aViennaPatternNode
]

{ #category : #accessing }
ViennaBindNode >> typeOrExpression [

	^ self at: 2
]
