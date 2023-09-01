Class {
	#name : #ViennaUseValueInAllOccurrencesTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaUseValueInAllOccurrencesTest >> createSpec [

	^ '
module A
exports all
definitions
values
	v = 2 * 3.14;
	v2 = (3.14 * 2) * x;
	z = (2 * 3.14) * x;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaUseValueInAllOccurrencesTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v2') expression
]

{ #category : #accessing }
ViennaUseValueInAllOccurrencesTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'v'
]

{ #category : #accessing }
ViennaUseValueInAllOccurrencesTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	v = 2 * 3.14;
	v2 = (3.14 * 2) * x;
	z = v * x;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaUseValueInAllOccurrencesTest >> setupRefactoring: aViennaRefactoring [

	
]
