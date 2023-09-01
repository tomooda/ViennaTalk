Class {
	#name : #ViennaExtractParameterFromExpressionInImplicitFunctionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractParameterFromExpressionInImplicitFunctionTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	f (x:nat) res: nat
	post res = 3.14 * x;
	g : nat -> nat
	g(x) == f(x);
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInImplicitFunctionTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f'
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInImplicitFunctionTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'f') post
		  expression2 expression1
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInImplicitFunctionTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	f (x:nat, pi:?) res: nat
	post res = pi * x;
	g : nat -> nat
	g(x) == f(x, 3.14);
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractParameterFromExpressionInImplicitFunctionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'pi'
]
