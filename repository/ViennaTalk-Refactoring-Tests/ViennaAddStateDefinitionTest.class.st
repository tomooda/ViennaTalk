Class {
	#name : #ViennaAddStateDefinitionTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddStateDefinitionTest >> createSpec [

	^ '
module A
exports all
definitions
end A
module B
exports all
definitions
state S of
b : nat
init s == s = mk_S(0)
end
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddStateDefinitionTest >> findFailureAst [

	^ self spec moduleNamed: 'B'
]

{ #category : #accessing }
ViennaAddStateDefinitionTest >> findSuccessAst [

	^ self spec moduleNamed: 'A'
]

{ #category : #accessing }
ViennaAddStateDefinitionTest >> resultingSpec [

	^ '
module A
exports all
definitions
state S of
init s == s = mk_S()
end
end A
module B
exports all
definitions
state S of
b : nat
init s == s = mk_S(0)
end
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaAddStateDefinitionTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'S'
]
