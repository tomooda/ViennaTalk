Class {
	#name : #ViennaRenameStateVariableTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRenameStateVariableTest >> createSpec [

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
ViennaRenameStateVariableTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op'
]

{ #category : #accessing }
ViennaRenameStateVariableTest >> findSuccessAst [

	^ (ViennaLocalNameNode identifier: 'x')
		  parent: ((self spec moduleNamed: 'A') resolveIdentifier: 'op');
		  yourself
]

{ #category : #accessing }
ViennaRenameStateVariableTest >> resultingSpec [

	^ '
module A
exports all
definitions
state S of
	z : nat
init s == s = mk_S(0)
end
operations
	op:()==>()
	op() == z := 0;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaRenameStateVariableTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'z'
]
