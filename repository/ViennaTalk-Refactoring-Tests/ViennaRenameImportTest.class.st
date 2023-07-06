Class {
	#name : #ViennaRenameImportTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaRenameImportTest >> createSpec [

	^ '
module A
imports from B operations op:()==>()
exports all
definitions
operations
	op : () ==> ()
	op() == B`op();
end A
module B
exports all
definitions
operations
	op : () ==> ()
	op() == skip;
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaRenameImportTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op'
]

{ #category : #accessing }
ViennaRenameImportTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A')
		  importAtModuleIdentifier: 'B'
		  identifier: 'op'
]

{ #category : #accessing }
ViennaRenameImportTest >> resultingSpec [

	^ '
module A
imports from B operations op:()==>() renamed op_B
exports all
definitions
operations
	op : () ==> ()
	op() == op_B();
end A
module B
exports all
definitions
operations
	op : () ==> ()
	op() == skip;
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaRenameImportTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'op_B'
]
