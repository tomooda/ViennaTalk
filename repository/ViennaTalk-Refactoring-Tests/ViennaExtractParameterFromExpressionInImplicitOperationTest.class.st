Class {
	#name : #ViennaExtractParameterFromExpressionInImplicitOperationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractParameterFromExpressionInImplicitOperationTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op (x:nat) res: nat
	post res = 3.14 * x;
	op2 : nat ==> nat
	op2(x) == return op(x);
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInImplicitOperationTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op'
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInImplicitOperationTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') post
		  expression2 expression1
]

{ #category : #accessing }
ViennaExtractParameterFromExpressionInImplicitOperationTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op (x:nat, pi:?) res: nat
	post res = pi * x;
	op2 : nat ==> nat
	op2(x) == return op(x, 3.14);
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractParameterFromExpressionInImplicitOperationTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'pi'
]
