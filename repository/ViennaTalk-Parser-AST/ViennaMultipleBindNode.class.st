Class {
	#name : #ViennaMultipleBindNode,
	#superclass : #ViennaPatternBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaMultipleBindNode class >> isAbstract [

	^ self = ViennaMultipleBindNode
]

{ #category : #testing }
ViennaMultipleBindNode >> isViennaMultipleBindNode [

	^ true
]

{ #category : #accessing }
ViennaMultipleBindNode >> patternList [

	^ self at: 1
]

{ #category : #accessing }
ViennaMultipleBindNode >> patternList: aViennaPatternListNode [

	self at: 1 put: aViennaPatternListNode
]

{ #category : #enumerating }
ViennaMultipleBindNode >> patternsDo: aBlock [

	self patternList do: aBlock
]
