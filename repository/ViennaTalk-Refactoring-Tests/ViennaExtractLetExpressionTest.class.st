Class {
	#name : #ViennaExtractLetExpressionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractLetExpressionTest >> createSpec [

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
	op(x) == return (x + 1) * x;
	pure op2 : nat ==> nat
	op2(x) == return op(x);
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractLetExpressionTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op2') statement
		  expression expression
]

{ #category : #accessing }
ViennaExtractLetExpressionTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  expression expression1
]

{ #category : #accessing }
ViennaExtractLetExpressionTest >> resultingSpec [

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
	op(x) == return (let v = x + 1 in v) * x;
	pure op2 : nat ==> nat
	op2(x) == return op(x);
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractLetExpressionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'v'
]
