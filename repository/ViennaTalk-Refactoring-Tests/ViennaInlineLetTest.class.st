Class {
	#name : #ViennaInlineLetTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaInlineLetTest >> createSpec [

	^ '
module A
exports all
definitions
values
	v = let x = y + 1, y = 2 in x + y + 3;
	v2 = 2;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaInlineLetTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v2') expression
]

{ #category : #accessing }
ViennaInlineLetTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v') expression
]

{ #category : #accessing }
ViennaInlineLetTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	v = (2 + 1) + 2 + 3;
	v2 = 2;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaInlineLetTest >> setupRefactoring: aViennaRefactoring [

	
]
