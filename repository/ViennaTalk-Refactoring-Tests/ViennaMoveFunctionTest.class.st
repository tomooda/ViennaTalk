Class {
	#name : #ViennaMoveFunctionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaMoveFunctionTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == x + 1;
	g : nat -> nat
	g(x) == f(x+2)*3;
end A
module B
exports all
definitions
functions
	g : nat -> nat
	g(x) == x;
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaMoveFunctionTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'f') expression
		  expression1
]

{ #category : #accessing }
ViennaMoveFunctionTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f'
]

{ #category : #accessing }
ViennaMoveFunctionTest >> resultingSpec [

	^ '
module A
imports from B functions f : nat -> nat
exports all
definitions
functions
	g : nat -> nat
	g(x) == B`f(x+2)*3;
end A
module B
exports all
definitions
functions
	g : nat -> nat
	g(x) == x;
	f : nat -> nat
	f(x) == x + 1;
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaMoveFunctionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring
		destinationModule: (spec moduleNamed: 'B');
		okToAddImports: true
]
