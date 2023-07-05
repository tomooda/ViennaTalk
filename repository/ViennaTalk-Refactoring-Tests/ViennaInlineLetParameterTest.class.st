Class {
	#name : #ViennaInlineLetParameterTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaInlineLetParameterTest >> createSpec [

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
ViennaInlineLetParameterTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v2') expression
]

{ #category : #accessing }
ViennaInlineLetParameterTest >> findSuccessAst [

	((self spec moduleNamed: 'A') resolveIdentifier: 'v') expression
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: 'y' ]
		do: [ :node | ^ node ].
	^ nil
]

{ #category : #accessing }
ViennaInlineLetParameterTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	v = let x = 2 + 1 in x + 2 + 3;
	v2 = 2;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaInlineLetParameterTest >> setupRefactoring: aViennaRefactoring [

	
]
