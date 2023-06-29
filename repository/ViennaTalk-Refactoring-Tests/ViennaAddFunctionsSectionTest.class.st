Class {
	#name : #ViennaAddFunctionsSectionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #running }
ViennaAddFunctionsSectionTest >> assertExecute [

	self assert: self spec equals: '
module A
exports all
definitions
operations
	op: () ==> ()
	op() == skip;
functions
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddFunctionsSectionTest >> createSpec [

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
ViennaAddFunctionsSectionTest >> findFailureAst [

	^ nil
]

{ #category : #accessing }
ViennaAddFunctionsSectionTest >> findSuccessAst [

	^ self spec moduleNamed: 'A'
]

{ #category : #running }
ViennaAddFunctionsSectionTest >> setupRefactoring: aViennaRefactoring [

	
]
