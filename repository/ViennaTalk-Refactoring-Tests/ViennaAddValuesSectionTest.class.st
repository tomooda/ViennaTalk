Class {
	#name : #ViennaAddValuesSectionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #running }
ViennaAddValuesSectionTest >> assertExecute [

	self assert: self spec equals: '
module A
exports all
definitions
operations
	op: () ==> ()
	op() == skip;
values
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddValuesSectionTest >> createSpec [

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
ViennaAddValuesSectionTest >> findFailureAst [

	^ nil
]

{ #category : #accessing }
ViennaAddValuesSectionTest >> findSuccessAst [

	^ self spec moduleNamed: 'A'
]

{ #category : #running }
ViennaAddValuesSectionTest >> setupRefactoring: aViennaRefactoring [

	
]
