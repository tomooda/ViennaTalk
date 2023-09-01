Class {
	#name : #ViennaUseFunctionInAllOccurrencesTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaUseFunctionInAllOccurrencesTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == x + 1;
	f2 : nat -> nat
	f2(x) == 1 + x;
	g : nat -> nat
	g(x) == (x + 1) + 1;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaUseFunctionInAllOccurrencesTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f1'
]

{ #category : #accessing }
ViennaUseFunctionInAllOccurrencesTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f'
]

{ #category : #accessing }
ViennaUseFunctionInAllOccurrencesTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == x + 1;
	f2 : nat -> nat
	f2(x) == 1 + x;
	g : nat -> nat
	g(x) == f(f(x));
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaUseFunctionInAllOccurrencesTest >> setupRefactoring: aViennaRefactoring [

	
]
