Class {
	#name : #ViennaAddUnitTestingModuleTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddUnitTestingModuleTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op: () ==> ()
	op() == skip;
functions
	f : nat -> nat
	f(x) == x + 1;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddUnitTestingModuleTest >> findFailureAst [

	^ nil
]

{ #category : #accessing }
ViennaAddUnitTestingModuleTest >> findSuccessAst [

	^ self spec moduleNamed: 'A'
]

{ #category : #accessing }
ViennaAddUnitTestingModuleTest >> resultingSpec [

	^ ('
module A
exports all
definitions
operations
	op: () ==> ()
	op() == skip;
functions
	f : nat -> nat
	f(x) == x + 1;
end A
' , ViennaModuleNode unitTestingSource) asViennaDocumentAst
]

{ #category : #running }
ViennaAddUnitTestingModuleTest >> setupRefactoring: aViennaRefactoring [

	
]
