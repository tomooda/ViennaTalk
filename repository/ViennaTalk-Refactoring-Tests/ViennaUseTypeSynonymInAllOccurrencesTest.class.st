Class {
	#name : #ViennaUseTypeSynonymInAllOccurrencesTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaUseTypeSynonymInAllOccurrencesTest >> createSpec [

	^ '
module A
exports all
definitions
types
	T = nat * nat;
	T2 = nat * char inv mk_(n, c) == n > 0;
	T3 = (nat * nat) | nat;
	T4 = (nat * char) | nat;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaUseTypeSynonymInAllOccurrencesTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'T2'
]

{ #category : #accessing }
ViennaUseTypeSynonymInAllOccurrencesTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'T'
]

{ #category : #accessing }
ViennaUseTypeSynonymInAllOccurrencesTest >> resultingSpec [

	^ '
module A
exports all
definitions
types
	T = nat * nat;
	T2 = nat * char inv mk_(n, c) == n > 0;
	T3 = T | nat;
	T4 = (nat * char) | nat;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaUseTypeSynonymInAllOccurrencesTest >> setupRefactoring: aViennaRefactoring [

	
]
