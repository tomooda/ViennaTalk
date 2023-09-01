Class {
	#name : #ViennaAddTypesSectionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddTypesSectionTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op: () ==> ()
	op() == skip;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddTypesSectionTest >> findFailureAst [

	^ nil
]

{ #category : #accessing }
ViennaAddTypesSectionTest >> findSuccessAst [

	^ self spec moduleNamed: 'A'
]

{ #category : #accessing }
ViennaAddTypesSectionTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op: () ==> ()
	op() == skip;
types
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddTypesSectionTest >> setupRefactoring: aViennaRefactoring [

	
]
