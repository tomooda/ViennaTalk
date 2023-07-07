Class {
	#name : #ViennaUseFunctionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaUseFunctionTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == x + 1;
	g : nat -> nat
	g(x) == (x + 1) * 2;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaUseFunctionTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'g') expression
]

{ #category : #accessing }
ViennaUseFunctionTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'g') expression
		  expression1
]

{ #category : #accessing }
ViennaUseFunctionTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == x + 1;
	g : nat -> nat
	g(x) == f(x) * 2;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaUseFunctionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring functionsAndBindsIndex: 1
]
