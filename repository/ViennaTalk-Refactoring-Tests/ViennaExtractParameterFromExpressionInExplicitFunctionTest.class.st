Class {
	#name : #ViennaExtractParameterFromExpressionInExplicitFunctionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractParameterFromExpressionInExplicitFunctionTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	f : nat -> nat
	f(x) == 3.14 * x;
	g : nat -> nat
	g(x) == f(x);
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInExplicitFunctionTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f'
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInExplicitFunctionTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'f') expression
		  expression1
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInExplicitFunctionTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	f : nat * ? -> nat
	f(x, pi) == pi * x;
	g : nat -> nat
	g(x) == f(x, 3.14);
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractParameterFromExpressionInExplicitFunctionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'pi'
]
