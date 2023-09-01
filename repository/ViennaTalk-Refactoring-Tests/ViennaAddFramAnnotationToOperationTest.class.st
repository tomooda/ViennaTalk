Class {
	#name : #ViennaAddFramAnnotationToOperationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddFramAnnotationToOperationTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op: () ==> ()
	op() == skip;
functions
	f : nat -> nat
	f(x) == x + 1;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperationTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f'
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperationTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op'
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperationTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	--@FRAM Output nothing
	op: () ==> ()
	op() == skip;
functions
	f : nat -> nat
	f(x) == x + 1;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddFramAnnotationToOperationTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring
		newAspect: 'Output';
		newName: 'nothing'
]
