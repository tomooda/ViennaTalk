Class {
	#name : #ViennaMoveTypeTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaMoveTypeTest >> createSpec [

	^ '
module A
exports all
definitions
types
	T1 = nat;
	T2 = T1;
end A
module B
imports from A types T1 renamed TA;
exports all
definitions
types
	T = TA
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaMoveTypeTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'T1') type
]

{ #category : #accessing }
ViennaMoveTypeTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'T1'
]

{ #category : #accessing }
ViennaMoveTypeTest >> resultingSpec [

	^ '
module A
imports from B types T1
exports all
definitions
types
	T2 = B`T1;
end A
module B
exports all
definitions
types
	T = T1;
	T1 = nat
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaMoveTypeTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring
		destinationModule: (spec moduleNamed: 'B');
		okToAddImports: true
]
