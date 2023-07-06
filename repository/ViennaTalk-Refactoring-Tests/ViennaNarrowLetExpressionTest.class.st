Class {
	#name : #ViennaNarrowLetExpressionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaNarrowLetExpressionTest >> createSpec [

	^ '
module A
exports all
definitions
values
	v = let x = 1 in x * 2 + 3;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaNarrowLetExpressionTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v') expression
		  expression
]

{ #category : #accessing }
ViennaNarrowLetExpressionTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v') expression
]

{ #category : #accessing }
ViennaNarrowLetExpressionTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	v = (let x = 1 in x * 2) + 3;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaNarrowLetExpressionTest >> setupRefactoring: aViennaRefactoring [

	
]
