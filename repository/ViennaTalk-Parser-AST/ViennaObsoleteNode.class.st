Class {
	#name : #ViennaObsoleteNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaObsoleteNode class >> isAbstract [

	^ self = ViennaObsoleteNode
]

{ #category : #'as yet unclassified' }
ViennaObsoleteNode >> isViennaObsoleteNode [

	^ true
]
