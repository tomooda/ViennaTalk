Class {
	#name : #ViennaWidenLetStatementTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaWidenLetStatementTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> ()
	op() == (skip; let r = 2.0 in return 2 * r);
	op2 : () ==> ()
	op2() == let r = 2.0 in return 2 * r;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaWidenLetStatementTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op2') statement
]

{ #category : #accessing }
ViennaWidenLetStatementTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  second
]

{ #category : #accessing }
ViennaWidenLetStatementTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> ()
	op() == let r = 2.0 in (skip; return 2 * r);
	op2 : () ==> ()
	op2() == let r = 2.0 in return 2 * r;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaWidenLetStatementTest >> setupRefactoring: aViennaRefactoring [

	
]
