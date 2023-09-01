Class {
	#name : #ViennaExtractOperationFromLetExpressionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractOperationFromLetExpressionTest >> createSpec [

	^ '
module A
exports all
definitions
state S of
z : nat
init s == s = mk_S(0)
end
operations
	pure op : nat ==> nat
	op(x) == return let a = x + 1 in a * x * z;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpressionTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpressionTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  expression
]

{ #category : #accessing }
ViennaExtractOperationFromLetExpressionTest >> resultingSpec [

	^ '
module A
exports all
definitions
state S of
z : nat
init s == s = mk_S(0)
end
operations
	pure op : nat ==> nat
	op(x) == return op2(x+1, x);
	pure op2 : ? * ? ==> ?
	op2(a, x) == return a * x * z
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractOperationFromLetExpressionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'op2'
]
