Class {
	#name : #ViennaWidenLetStatement,
	#superclass : #ViennaWidenLet,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaWidenLetStatement >> acceptsDefinitionNode: aViennaNode [
	^ aViennaNode isViennaStatementNode
]

{ #category : #operations }
ViennaWidenLetStatement >> acceptsNode: aViennaNode [

	^ aViennaNode isViennaLetStatementNode
]

{ #category : #accessing }
ViennaWidenLetStatement >> sortingOrder [
	^ 3.61
]
