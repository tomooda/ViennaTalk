Class {
	#name : #ViennaPatternIdentifierNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaPatternIdentifierNode >> identifier [

	^ self at: 1
]

{ #category : #testing }
ViennaPatternIdentifierNode >> isViennaPatternIdentifierNode: aString [

	^ self identifier = aString
]

{ #category : #'as yet unclassified' }
ViennaPatternIdentifierNode >> label [

	^ 'PatternIdentifier'
]
