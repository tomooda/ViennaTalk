Class {
	#name : #ViennaWidenLetExpressionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaWidenLetExpressionTest >> createSpec [

	^ '
module A
exports all
definitions
values
	v = 3.14 * let r = 2.0 in (2 * r);
	v2 = let r = 2.0 in (2 * r);
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaWidenLetExpressionTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v2') expression
]

{ #category : #accessing }
ViennaWidenLetExpressionTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v') expression
		  expression2
]

{ #category : #accessing }
ViennaWidenLetExpressionTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	v = let r = 2.0 in (3.14 *  (2 * r));
	v2 = let r = 2.0 in (2 * r);
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaWidenLetExpressionTest >> setupRefactoring: aViennaRefactoring [

	
]
