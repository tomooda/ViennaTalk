Class {
	#name : #ViennaRemoveEmptySectionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRemoveEmptySectionTest >> createSpec [

	^ '
module A
exports all
definitions
functions
operations
	op : () ==> nat
	op() == skip;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRemoveEmptySectionTest >> findFailureAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaOperationDefinitionsNode
		do: [ :node | ^ node ].
	^ nil
]

{ #category : #accessing }
ViennaRemoveEmptySectionTest >> findSuccessAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaFunctionDefinitionsNode
		do: [ :node | ^ node ].
	^ nil
]

{ #category : #accessing }
ViennaRemoveEmptySectionTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> nat
	op() == skip;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaRemoveEmptySectionTest >> setupRefactoring: aViennaRefactoring [

	
]
