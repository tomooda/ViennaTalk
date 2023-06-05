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

	^ aViennaNode label = 'LetExpressionStatement'
]

{ #category : #operations }
ViennaWidenLetStatement >> check [

	ast ifNil: [ ^ false ].
	ast label = 'LetExpressionStatement' ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	^ true
]

{ #category : #accessing }
ViennaWidenLetStatement >> sortingOrder [
	^ 3.61
]
