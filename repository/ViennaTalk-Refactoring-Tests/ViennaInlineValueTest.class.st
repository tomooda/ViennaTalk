Class {
	#name : #ViennaInlineValueTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaInlineValueTest >> createSpec [

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
ViennaInlineValueTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'y') expression
		  expression2
]

{ #category : #accessing }
ViennaInlineValueTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'y') expression
		  expression1
]

{ #category : #accessing }
ViennaInlineValueTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	x = 1;
	y = 1 + 2;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaInlineValueTest >> setupRefactoring: aViennaRefactoring [

	
]
