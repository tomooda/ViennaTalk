Class {
	#name : #ViennaExtractStateVariableTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractStateVariableTest >> createSpec [

	^ '
module A
exports all
definitions
values
	v = 1;
operations
	op : nat ==> nat
	op(x) == return 3.14 * v * x;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractStateVariableTest >> findFailureAst [

	((self spec moduleNamed: 'A') resolveIdentifier: 'v') expression
		allDescendantsSuchThat: [ :n | n isViennaSymbolicLiteralNode: '1' ]
		do: [ :n | ^ n ].
	^ nil
]

{ #category : #accessing }
ViennaExtractStateVariableTest >> findSuccessAst [

	((self spec moduleNamed: 'A') resolveIdentifier: 'op')
		allDescendantsSuchThat: [ :n |
		n isViennaSymbolicLiteralNode: '3.14' ]
		do: [ :n | ^ n ].
	^ nil
]

{ #category : #accessing }
ViennaExtractStateVariableTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	v = 1;
operations
	op : nat ==> nat
	op(x) == return pi * v * x;
state State of
	pi : ?
init s == s = mk_State(3.14)
end
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractStateVariableTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'pi'
]
