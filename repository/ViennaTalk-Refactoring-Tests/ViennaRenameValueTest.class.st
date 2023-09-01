Class {
	#name : #ViennaRenameValueTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRenameValueTest >> createSpec [

	^ '
module A
exports all
definitions
values
	mk_(x, x, y) = mk_(1, 1, 2);
end A
module B
imports from A values x renamed x_A
exports all
definitions
values
	v = A`x + x_A
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRenameValueTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'x'
]

{ #category : #accessing }
ViennaRenameValueTest >> findSuccessAst [

	^ (ViennaLocalNameNode identifier: 'x')
		  parent: ((self spec moduleNamed: 'A') resolveIdentifier: 'x');
		  yourself
]

{ #category : #accessing }
ViennaRenameValueTest >> resultingSpec [

	^ '
module A
exports all
definitions
values
	mk_(z, z, y) = mk_(1, 1, 2);
end A
module B
imports from A values z renamed x_A
exports all
definitions
values
	v = A`z + x_A
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaRenameValueTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'z'
]
