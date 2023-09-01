Class {
	#name : #ViennaUseValueTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaUseValueTest >> createSpec [

	^ '
module A
exports all
definitions
values
	v = (2 * 3.14) * x;
	v2 = (3.14 * 2) * x;
	z = 2 * 3.14;
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaUseValueTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v2') expression
		  expression1
]

{ #category : #accessing }
ViennaUseValueTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'v') expression
		  expression1
]

{ #category : #accessing }
ViennaUseValueTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	v = z * x;
	v2 = (3.14 * 2) * x;
	z = 2 * 3.14;
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaUseValueTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring valuesIndex: 1
]
