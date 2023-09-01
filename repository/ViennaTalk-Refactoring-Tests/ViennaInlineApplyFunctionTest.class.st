Class {
	#name : #ViennaInlineApplyFunctionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaInlineApplyFunctionTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == x + 1;
	g : nat -> nat
	g(x) == f(x * 2) + 3;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaInlineApplyFunctionTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'f') expression
		  expression1
]

{ #category : #accessing }
ViennaInlineApplyFunctionTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'g') expression
		  expression1
]

{ #category : #accessing }
ViennaInlineApplyFunctionTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == x + 1;
	g : nat -> nat
	g(x) == (let x : nat = x * 2 in x + 1) + 3;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaInlineApplyFunctionTest >> setupRefactoring: aViennaRefactoring [

	
]
