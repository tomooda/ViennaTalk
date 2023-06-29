Class {
	#name : #ViennaAddTestModuleTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #running }
ViennaAddTestModuleTest >> assertExecute [

	self assert: (self spec moduleNamed: 'ATest') notNil
]

{ #category : #accessing }
ViennaAddTestModuleTest >> createSpec [

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

{ #category : #accessing }
ViennaAddTestModuleTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'f'
]

{ #category : #accessing }
ViennaAddTestModuleTest >> findSuccessAst [

	^ self spec moduleNamed: 'A'
]

{ #category : #accessing }
ViennaAddTestModuleTest >> setupRefactoring: aViennaRefactoring [

	
]
