Class {
	#name : #ViennaInlineApplyFunctionAndRemoveTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemoveTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == x + 1;
	f2 : nat -> nat
	f2(x) == x + 1;
	g : nat -> nat
	g(x) == f(x * 2) + f2(x);
end A
module B
imports from A functions f2: nat -> nat
exports all
definitions
functions
	g : nat -> nat
	g(x) == f2(x*2);
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemoveTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f2'
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemoveTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f'
]

{ #category : #accessing }
ViennaInlineApplyFunctionAndRemoveTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	f2 : nat -> nat
	f2(x) == x + 1;
	g : nat -> nat
	g(x) == (let x : nat = x * 2 in x + 1) + f2(x);
end A
module B
imports from A functions f2: nat -> nat
exports all
definitions
functions
	g : nat -> nat
	g(x) == f2(x*2);
end B' asViennaDocumentAst
]

{ #category : #running }
ViennaInlineApplyFunctionAndRemoveTest >> setupRefactoring: aViennaRefactoring [

	
]
