Class {
	#name : #ViennaAddUnitTestingModuleTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #running }
ViennaAddUnitTestingModuleTest >> assertExecute [

	self assert: (self spec moduleNamed: 'UnitTesting') notNil
]

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

{ #category : #running }
ViennaAddUnitTestingModuleTest >> setupRefactoring: aViennaRefactoring [

	
]
