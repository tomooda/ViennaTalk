Class {
	#name : #ViennaAddImplicitFunctionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddImplicitFunctionTest >> createSpec [

	^ '
module A
exports all
definitions
functions
operations
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddImplicitFunctionTest >> findFailureAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaOperationDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddImplicitFunctionTest >> findSuccessAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaFunctionDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddImplicitFunctionTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	f () res:?
	post true
operations
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddImplicitFunctionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'f'
]
