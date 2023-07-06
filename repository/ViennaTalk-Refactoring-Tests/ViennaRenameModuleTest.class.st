Class {
	#name : #ViennaRenameModuleTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRenameModuleTest >> createSpec [

	^ '
module A
exports all
definitions
types
	T = nat
end A
module B
imports from A all
exports all
definitions
types
	T2 = A`T
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRenameModuleTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'T'
]

{ #category : #accessing }
ViennaRenameModuleTest >> findSuccessAst [

	^ self spec moduleNamed: 'A'
]

{ #category : #accessing }
ViennaRenameModuleTest >> resultingSpec [

	^ '
module Z
exports all
definitions
types
	T = nat
end Z
module B
imports from Z all
exports all
definitions
types
	T2 = Z`T
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaRenameModuleTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'Z'
]
