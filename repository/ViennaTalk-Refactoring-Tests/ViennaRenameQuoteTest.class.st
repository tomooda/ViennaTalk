Class {
	#name : #ViennaRenameQuoteTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRenameQuoteTest >> createSpec [

	^ '
module A
exports all
definitions
types
	T = <OK> | <ERROR>
values
	v : T = <OK>
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRenameQuoteTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'T')
		  typeDefinition type
]

{ #category : #accessing }
ViennaRenameQuoteTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v') expression
]

{ #category : #accessing }
ViennaRenameQuoteTest >> resultingSpec [

	^ '
module A
exports all
definitions
types
	T = <Z> | <ERROR>
values
	v : T = <Z>
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaRenameQuoteTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: '<Z>'
]
