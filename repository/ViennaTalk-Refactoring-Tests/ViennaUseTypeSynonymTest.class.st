Class {
	#name : #ViennaUseTypeSynonymTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaUseTypeSynonymTest >> createSpec [

	^ '
module A
exports all
definitions
types
	T = (nat * nat) | nat;
	T2 = (nat * char) | nat;
	T3 = nat * nat;
	T4 = nat * char inv mk_(n, c) == n > 0;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaUseTypeSynonymTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'T2') type first
]

{ #category : #accessing }
ViennaUseTypeSynonymTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'T') type first
]

{ #category : #accessing }
ViennaUseTypeSynonymTest >> resultingSpec [

	^ '
module A
exports all
definitions
types
	T = T3 | nat;
	T2 = (nat * char) | nat;
	T3 = nat * nat;
	T4 = nat * char inv mk_(n, c) == n > 0;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaUseTypeSynonymTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring typeSynonymIndex: 1
]
