Class {
	#name : #ViennaNarrowLetStatementTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaNarrowLetStatementTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> nat
	op() == let x = 1 in if true then return x else return 1;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaNarrowLetStatementTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  body
]

{ #category : #accessing }
ViennaNarrowLetStatementTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
]

{ #category : #accessing }
ViennaNarrowLetStatementTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> nat
	op() == if true then let x = 1 in return x else return 1;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaNarrowLetStatementTest >> setupRefactoring: aViennaRefactoring [

	
]
