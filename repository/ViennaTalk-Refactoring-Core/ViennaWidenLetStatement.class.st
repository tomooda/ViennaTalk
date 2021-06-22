Class {
	#name : #ViennaWidenLetStatement,
	#superclass : #ViennaWidenLet,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaWidenLetStatement >> acceptsAstLabel: aString [
	^ aString = 'LetStatement'
]

{ #category : #testing }
ViennaWidenLetStatement >> acceptsDefinitionNode: aViennaNode [
	^ aViennaNode isStatementNode
]

{ #category : #accessing }
ViennaWidenLetStatement >> sortingOrder [
	^ 3.61
]
