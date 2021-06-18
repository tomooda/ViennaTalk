Class {
	#name : #ViennaExpandValue,
	#superclass : #ViennaRefactoring,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExpandValue >> check [
	^ ast notNil and: [ ast isLocalValueNameNode ]
]

{ #category : #operations }
ViennaExpandValue >> execute [
	((ast definitionOfLocalName: ast first)
		parentLabelled: 'ValueDefinition'
		ifAbsent: [ nil ])
		ifNotNil:
			[ :valueDefinition | self replaceNode: ast with: valueDefinition third copyFragment ]
]

{ #category : #accessing }
ViennaExpandValue >> name [
	^ 'expand ' asText , ast source asText allBold
]
