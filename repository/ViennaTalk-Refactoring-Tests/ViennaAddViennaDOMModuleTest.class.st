Class {
	#name : #ViennaAddViennaDOMModuleTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #running }
ViennaAddViennaDOMModuleTest >> assertExecute [

	self assert: (self spec moduleNamed: 'ViennaDOM') notNil
]

{ #category : #accessing }
ViennaAddViennaDOMModuleTest >> createSpec [

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
ViennaAddViennaDOMModuleTest >> findFailureAst [

	^ nil
]

{ #category : #accessing }
ViennaAddViennaDOMModuleTest >> findSuccessAst [

	^ self spec moduleNamed: 'A'
]

{ #category : #running }
ViennaAddViennaDOMModuleTest >> setupRefactoring: aViennaRefactoring [

	
]
