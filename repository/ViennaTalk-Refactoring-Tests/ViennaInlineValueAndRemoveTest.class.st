Class {
	#name : #ViennaInlineValueAndRemoveTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaInlineValueAndRemoveTest >> createSpec [

	^ '
module A
exports all
definitions
values
	x = 1;
	y = x + 2;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaInlineValueAndRemoveTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'x') expression
]

{ #category : #accessing }
ViennaInlineValueAndRemoveTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'x'
]

{ #category : #accessing }
ViennaInlineValueAndRemoveTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	y = 1 + 2;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaInlineValueAndRemoveTest >> setupRefactoring: aViennaRefactoring [

	
]
