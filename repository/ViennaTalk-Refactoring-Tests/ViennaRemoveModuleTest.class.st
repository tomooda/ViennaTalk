Class {
	#name : #ViennaRemoveModuleTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRemoveModuleTest >> createSpec [

	^ '
module A
imports from B all
exports all
definitions
operations
	op : () ==> ()
	op() == skip;
end A
module B
exports all
definitions
values
	v = 1;
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRemoveModuleTest >> findFailureAst [

	^ self spec moduleNamed: 'B'
]

{ #category : #accessing }
ViennaRemoveModuleTest >> findSuccessAst [

	^ self spec moduleNamed: 'A'
]

{ #category : #accessing }
ViennaRemoveModuleTest >> resultingSpec [

	^ '
module B
exports all
definitions
values
	v = 1;
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaRemoveModuleTest >> setupRefactoring: aViennaRefactoring [

	
]
