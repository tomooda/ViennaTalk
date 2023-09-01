Class {
	#name : #ViennaAddImplicitOperationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddImplicitOperationTest >> createSpec [

	^ '
module A
exports all
definitions
functions
operations
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddImplicitOperationTest >> findFailureAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaFunctionDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddImplicitOperationTest >> findSuccessAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaOperationDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddImplicitOperationTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
operations
	op ()
	post true
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddImplicitOperationTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'op'
]
