Class {
	#name : #ViennaRenameOperationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRenameOperationTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op:()==>()
	op() == skip;
end A
module B
imports from A operations op renamed op_A
exports all
definitions
operations
	op : () ==> ()
	op() == (A`op(); op_A());
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRenameOperationTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
]

{ #category : #accessing }
ViennaRenameOperationTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op'
]

{ #category : #accessing }
ViennaRenameOperationTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	z:()==>()
	z() == skip;
end A
module B
imports from A operations z renamed op_A
exports all
definitions
operations
	op : () ==> ()
	op() == (A`z(); op_A());
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaRenameOperationTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'z'
]
