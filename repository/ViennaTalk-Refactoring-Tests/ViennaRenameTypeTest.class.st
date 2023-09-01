Class {
	#name : #ViennaRenameTypeTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRenameTypeTest >> createSpec [

	^ '
module A
exports all
definitions
types
	T = nat;
end A
module B
imports from A types T renamed T_A
exports all
definitions
types
	T = A`T * T_A
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRenameTypeTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'T') type
]

{ #category : #accessing }
ViennaRenameTypeTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'T'
]

{ #category : #accessing }
ViennaRenameTypeTest >> resultingSpec [

	^ '
module A
exports all
definitions
types
	Z = nat;
end A
module B
imports from A types Z renamed T_A
exports all
definitions
types
	T = A`Z * T_A
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaRenameTypeTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'Z'
]
