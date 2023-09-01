Class {
	#name : #ViennaInlineBlockStatementTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaInlineBlockStatementTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> ()
	op() == (dcl x:nat := 1; (dcl y:nat := 2; skip); (dcl x:nat := 3; skip); skip);
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaInlineBlockStatementTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  third
]

{ #category : #accessing }
ViennaInlineBlockStatementTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  second
]

{ #category : #accessing }
ViennaInlineBlockStatementTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> ()
	op() == (dcl x:nat := 1, y:nat; y := 2; skip; (dcl x:nat := 3; skip); skip);
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaInlineBlockStatementTest >> setupRefactoring: aViennaRefactoring [

	
]

{ #category : #running }
ViennaInlineBlockStatementTest >> testInlineBlockStatementWithReturnStatementShouldFail [

	| ast |
	ast := 'module A
	exports all
	definitions
	operations
	op : () ==> ()
	op() == (dcl x: nat := 1; (dcl y:nat := 2; return 3); skip)
	end A' asViennaDocumentAst.
	self deny: (ViennaInlineBlockStatement new ast:
			 ((ast moduleNamed: 'A') resolveIdentifier: 'op') statement second)
			check
]
