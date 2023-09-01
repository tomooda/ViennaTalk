Class {
	#name : #ViennaAddViennaDOMModuleTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

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

{ #category : #accessing }
ViennaAddViennaDOMModuleTest >> resultingSpec [

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
' , ViennaModuleNode viennaDOMSource) asViennaDocumentAst
]

{ #category : #running }
ViennaAddViennaDOMModuleTest >> setupRefactoring: aViennaRefactoring [

	
]
