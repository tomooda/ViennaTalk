Class {
	#name : #ViennaAddValueTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddValueTest >> createSpec [

	^ '
module A
exports all
definitions
types
values
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddValueTest >> findFailureAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaTypeDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddValueTest >> findSuccessAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaValueDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddValueTest >> resultingSpec [

	^ '
module A
exports all
definitions
types
values
	v : ? = undefined
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddValueTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'v'
]
