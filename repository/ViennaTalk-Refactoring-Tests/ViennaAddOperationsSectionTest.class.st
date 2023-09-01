Class {
	#name : #ViennaAddOperationsSectionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddOperationsSectionTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == x + 1;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddOperationsSectionTest >> findFailureAst [

	^ nil
]

{ #category : #accessing }
ViennaAddOperationsSectionTest >> findSuccessAst [

	^ self spec moduleNamed: 'A'
]

{ #category : #accessing }
ViennaAddOperationsSectionTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == x + 1;
operations
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddOperationsSectionTest >> setupRefactoring: aViennaRefactoring [

	
]
