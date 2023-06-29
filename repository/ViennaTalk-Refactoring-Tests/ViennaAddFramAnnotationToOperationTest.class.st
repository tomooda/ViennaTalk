Class {
	#name : #ViennaAddFramAnnotationToOperationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #tests }
ViennaAddFramAnnotationToOperationTest >> assertExecute [

	self
		assert:
		((spec moduleNamed: 'A') resolveIdentifier: 'op') annotations size
		equals: 1.
	self
		assert:
			((spec moduleNamed: 'A') resolveIdentifier: 'op') annotations first
				substrings
		equals: #( 'FRAM' 'Output' 'nothing' )
]

{ #category : #tests }
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

{ #category : #tests }
ViennaAddFramAnnotationToOperationTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op'
]

{ #category : #tests }
ViennaAddFramAnnotationToOperationTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring
		newAspect: 'Output';
		newName: 'nothing'
]
