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

{ #category : #operations }
ViennaWidenLetStatement >> check [

	ast ifNil: [ ^ false ].
	ast isViennaLetStatementNode ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	^ true
]

{ #category : #accessing }
ViennaWidenLetStatement >> sortingOrder [
	^ 3.61
]
