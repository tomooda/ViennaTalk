Class {
	#name : #ViennaExtractParameterExpressionInExplicitOperationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractParameterExpressionInExplicitOperationTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op : nat ==> nat
	op(x) == return 3.14 * x;
	op2 : nat ==> nat
	op2(x) == return op(1);
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractParameterExpressionInExplicitOperationTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op'
]

{ #category : #accessing }
ViennaExtractParameterExpressionInExplicitOperationTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  expression expression1
]

{ #category : #accessing }
ViennaExtractParameterExpressionInExplicitOperationTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op : nat * ? ==> nat
	op(x, pi) == return pi * x;
	op2 : nat ==> nat
	op2(x) == return op(1, 3.14);
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractParameterExpressionInExplicitOperationTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'pi'
]
