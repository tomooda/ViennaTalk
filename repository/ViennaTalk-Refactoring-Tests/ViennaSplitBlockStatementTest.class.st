Class {
	#name : #ViennaSplitBlockStatementTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaSplitBlockStatementTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> ()
	op() == (dcl x:nat := 0, y:nat := 1; x := 2; y := 3)
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaSplitBlockStatementTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  at: 2
]

{ #category : #accessing }
ViennaSplitBlockStatementTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  at: 3
]

{ #category : #accessing }
ViennaSplitBlockStatementTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> ()
	op() == (dcl x:nat := 0, y:nat := 1; (x := 2); (y := 3))
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaSplitBlockStatementTest >> setupRefactoring: aViennaRefactoring [

	
]
