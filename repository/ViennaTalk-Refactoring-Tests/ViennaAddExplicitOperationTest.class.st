Class {
	#name : #ViennaAddExplicitOperationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddExplicitOperationTest >> createSpec [

	^ '
module A
exports all
definitions
operations
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddExplicitOperationTest >> findFailureAst [

	^ nil
]

{ #category : #accessing }
ViennaAddExplicitOperationTest >> findSuccessAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaOperationDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddExplicitOperationTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> ()
	op() == skip
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddExplicitOperationTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'op'
]
