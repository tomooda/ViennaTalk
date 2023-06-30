Class {
	#name : #ViennaExtractOperationFromLetStatementTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractOperationFromLetStatementTest >> createSpec [

	^ '
module A
exports all
definitions
state S of
z : nat
init s == s = mk_S(0)
end
operations
	pure op : nat ==> ()
	op(x) == let a = x + 1 in z := a * x * z;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatementTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement statement
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatementTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatementTest >> resultingSpec [

	^ '
module A
exports all
definitions
state S of
	z : nat
init s == s = mk_S(0)
end

operations
	pure op : nat ==> ()
	op(x) == op2(x + 1, x);
	op2 : ? * ? ==> ()
	op2(a, x) == z := a * x * z;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractOperationFromLetStatementTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'op2'
]
