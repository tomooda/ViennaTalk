Class {
	#name : #ViennaRemoveFramAnnotationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRemoveFramAnnotationTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	--@FRAM Output something
	op : () ==> nat
	op() == skip;
	op2 : () ==> nat
	op2() == skip;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRemoveFramAnnotationTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op2'
]

{ #category : #accessing }
ViennaRemoveFramAnnotationTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op'
]

{ #category : #accessing }
ViennaRemoveFramAnnotationTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> nat
	op() == skip;
	op2 : () ==> nat
	op2() == skip;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaRemoveFramAnnotationTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring annotation: 'FRAM Output something'
]
