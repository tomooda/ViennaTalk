Class {
	#name : #ViennaAddTypeAliasTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddTypeAliasTest >> createSpec [

	^ '
module A
exports all
definitions
types
values
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddTypeAliasTest >> findFailureAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaValueDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddTypeAliasTest >> findSuccessAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaTypeDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddTypeAliasTest >> resultingSpec [

	^ '
module A
exports all
definitions
types
	T = ?
values
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddTypeAliasTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'T'
]
