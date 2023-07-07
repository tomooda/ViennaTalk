Class {
	#name : #ViennaRenameStateConstructorTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRenameStateConstructorTest >> createSpec [

	^ '
module A
exports all
definitions
state S of
	x : nat
init s == s = mk_S(0)
end
operations
	op:()==>()
	op() == x := 0;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRenameStateConstructorTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op'
]

{ #category : #accessing }
ViennaRenameStateConstructorTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'S'
]

{ #category : #accessing }
ViennaRenameStateConstructorTest >> resultingSpec [

	^ '
module A
exports all
definitions
state Z of
	x : nat
init s == s = mk_Z(0)
end
operations
	op:()==>()
	op() == x := 0;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaRenameStateConstructorTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'Z'
]
