Class {
	#name : #ViennaRemoveOperationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRemoveOperationTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> ()
	op() == skip;
	op2 : () ==> ()
	op2() == skip;
end A
module B
imports from A all
exports all
definitions
operations
	op : () ==> ()
	op() == A`op2();
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRemoveOperationTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op2'
]

{ #category : #accessing }
ViennaRemoveOperationTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op'
]

{ #category : #accessing }
ViennaRemoveOperationTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op2 : () ==> ()
	op2() == skip;
end A
module B
imports from A all
exports all
definitions
operations
	op : () ==> ()
	op() == A`op2();
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaRemoveOperationTest >> setupRefactoring: aViennaRefactoring [

	
]
