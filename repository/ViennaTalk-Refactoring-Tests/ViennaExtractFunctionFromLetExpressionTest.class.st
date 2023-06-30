Class {
	#name : #ViennaExtractFunctionFromLetExpressionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractFunctionFromLetExpressionTest >> createSpec [

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
	op(x) == return let a = x + 1 in a * x;
	pure op2 : nat ==> nat
	op2(x) == return let a = x + 1 in a * z;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpressionTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op2') statement
		  expression
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpressionTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  expression
]

{ #category : #accessing }
ViennaExtractFunctionFromLetExpressionTest >> resultingSpec [

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
	op(x) == return f(x+1, x);
	pure op2 : nat ==> nat
	op2(x) == return let a = x + 1 in a * z;
functions
	f : ? * ? -> ?
	f(a, x) == a * x
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractFunctionFromLetExpressionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'f'
]
