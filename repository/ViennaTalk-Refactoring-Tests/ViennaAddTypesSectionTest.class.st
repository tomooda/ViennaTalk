Class {
	#name : #ViennaAddTypesSectionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #running }
ViennaAddTypesSectionTest >> assertExecute [

	self assert: self spec equals: '
module A
exports all
definitions
operations
	op: () ==> ()
	op() == skip;
types
end A' asViennaDocumentAst
]

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

{ #category : #running }
ViennaAddTypesSectionTest >> setupRefactoring: aViennaRefactoring [

	
]
