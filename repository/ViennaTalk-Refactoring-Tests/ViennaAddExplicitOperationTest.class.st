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
functions
operations
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddExplicitOperationTest >> findFailureAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaFunctionDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
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

	^ 'module A
exports all
definitions
functions
operations
    op : () ==> ()
    op() == skip
    pre  true
    post  false;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddExplicitOperationTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'op'
]
