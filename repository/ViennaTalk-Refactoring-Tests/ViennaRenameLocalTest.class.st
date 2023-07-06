Class {
	#name : #ViennaRenameLocalTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRenameLocalTest >> createSpec [

	^ '
module A
imports from B operations op:()==>()
exports all
definitions
values
	v = let mk_(x, x) = mk_(1, 1) in x + 2;
	v2 = let mk_(x, y) = mk_(1, 1) in x + 2;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRenameLocalTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v2') expression
		  expression expression1
]

{ #category : #accessing }
ViennaRenameLocalTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v') expression
		  expression expression1
]

{ #category : #accessing }
ViennaRenameLocalTest >> resultingSpec [

	^ '
module A
imports from B operations op:()==>()
exports all
definitions
values
	v = let mk_(z, z) = mk_(1, 1) in z + 2;
	v2 = let mk_(x, y) = mk_(1, 1) in x + 2;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaRenameLocalTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'z'
]
