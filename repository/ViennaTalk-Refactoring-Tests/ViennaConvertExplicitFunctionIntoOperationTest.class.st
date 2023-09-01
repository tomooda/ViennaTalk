Class {
	#name : #ViennaConvertExplicitFunctionIntoOperationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaConvertExplicitFunctionIntoOperationTest >> createSpec [

	^ '
module A
exports all
definitions
values
	v = 1;
functions
	f : nat -> nat
	f(x) == x + 1
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaConvertExplicitFunctionIntoOperationTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'v'
]

{ #category : #accessing }
ViennaConvertExplicitFunctionIntoOperationTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f'
]

{ #category : #accessing }
ViennaConvertExplicitFunctionIntoOperationTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	v = 1;
operations
	pure f : nat ==> nat
	f(x) == return x + 1;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaConvertExplicitFunctionIntoOperationTest >> setupRefactoring: aViennaRefactoring [

	
]
