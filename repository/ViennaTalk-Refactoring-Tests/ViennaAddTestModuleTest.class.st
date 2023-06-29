Class {
	#name : #ViennaAddTestModuleTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

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
ViennaAddTestModuleTest >> resultingSpec [

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
' , ViennaModuleNode unitTestingSource, '
module ATest
imports 
	from UnitTesting 
		operations assert : bool * seq of char ==> () renamed assert;
		assertEquals  : ? * ? * seq of char ==> () renamed assertEquals;
		assertApproxEquals : real * real * real * seq of char ==> () renamed assertApproxEquals
exports all 
definitions 
end ATest') asViennaDocumentAst
]

{ #category : #running }
ViennaAddTestModuleTest >> setupRefactoring: aViennaRefactoring [

	
]
