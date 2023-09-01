Class {
	#name : #ViennaMoveValueTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaMoveValueTest >> createSpec [

	^ '
module A
exports all
definitions
values
	v1 = 1;
	v2 = v1 + 2;
end A
module B
imports from A values v1 renamed a_v1; v2 renamed a_v2;
exports all
definitions
values
	v2 = v1 + a_v1 + a_v2
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaMoveValueTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'v2'
]

{ #category : #accessing }
ViennaMoveValueTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'v1'
]

{ #category : #accessing }
ViennaMoveValueTest >> resultingSpec [

	^ '
module A
imports from B values v1
exports all
definitions
values
	v2 = B`v1 + 2;
end A
module B
imports from A values v2 renamed a_v2;
exports all
definitions
values
	v2 = v1 + v1 + a_v2;
	v1 = 1;
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaMoveValueTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring
		destinationModule: (spec moduleNamed: 'B');
		okToAddImports: true
]
