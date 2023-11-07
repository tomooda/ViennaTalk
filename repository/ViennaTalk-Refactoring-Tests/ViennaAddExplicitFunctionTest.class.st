Class {
	#name : #ViennaAddExplicitFunctionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddExplicitFunctionTest >> createSpec [

	^ '
module A
exports all
definitions
functions
operations
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddExplicitFunctionTest >> findFailureAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaOperationDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddExplicitFunctionTest >> findSuccessAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaFunctionDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddExplicitFunctionTest >> resultingSpec [

	^ 'module A
exports all
definitions
functions
    f : () -> ?
    f() == undefined
    pre true
    post false;
operations
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddExplicitFunctionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'f'
]
