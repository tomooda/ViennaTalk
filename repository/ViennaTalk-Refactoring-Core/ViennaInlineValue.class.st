Class {
	#name : #ViennaInlineValue,
	#superclass : #ViennaRefactoring,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaInlineValue >> check [
	^ ast notNil and: [ ast isLocalValueNameNode ]
]

{ #category : #operations }
ViennaInlineValue >> execute [
	^ ((ast definitionOfLocalName: ast first)
		parentLabelled: 'ValueDefinition'
		ifAbsent: [ nil ])
		ifNotNil:
			[ :valueDefinition | self replaceNode: ast with: valueDefinition third copyFragment ]
]

{ #category : #accessing }
ViennaInlineValue >> name [
	^ 'Inline ' asText
		, (self shortDescription: ast source) asText allBold
]

{ #category : #accessing }
ViennaInlineValue >> sortingOrder [
	^ 2.14
]
