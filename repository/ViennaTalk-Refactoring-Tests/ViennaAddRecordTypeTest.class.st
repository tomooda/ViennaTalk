Class {
	#name : #ViennaAddRecordTypeTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaAddRecordTypeTest >> createSpec [

	^ '
module A
exports all
definitions
types
values
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaAddRecordTypeTest >> findFailureAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaValueDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddRecordTypeTest >> findSuccessAst [

	(self spec moduleNamed: 'A')
		allDescendantsSuchThat: #isViennaTypeDefinitionsNode
		do: [ :node | ^ node ].
	^ self fail
]

{ #category : #accessing }
ViennaAddRecordTypeTest >> resultingSpec [

	^ '
module A
exports all
definitions
types
	T ::
values
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaAddRecordTypeTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'T'
]
