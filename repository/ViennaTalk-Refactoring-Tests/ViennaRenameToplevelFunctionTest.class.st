Class {
	#name : #ViennaRenameToplevelFunctionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRenameToplevelFunctionTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	f:nat -> nat
	f() == x + 1;
end A
module B
imports from A functions f renamed f_A
exports all
definitions
functions
	f : nat -> nat
	f(x) == A`f(x+2) * f_A(x+3);
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRenameToplevelFunctionTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'f') expression
]

{ #category : #accessing }
ViennaRenameToplevelFunctionTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f'
]

{ #category : #accessing }
ViennaRenameToplevelFunctionTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	z:nat -> nat
	z() == x + 1;
end A
module B
imports from A functions z renamed f_A
exports all
definitions
functions
	f : nat -> nat
	f(x) == A`z(x+2) * f_A(x+3);
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaRenameToplevelFunctionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'z'
]
