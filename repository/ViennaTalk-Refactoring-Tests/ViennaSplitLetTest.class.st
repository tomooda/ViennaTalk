Class {
	#name : #ViennaSplitLetTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaSplitLetTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> ()
	op() == let x:nat = 0, y:nat = 1 in (x := 2; y := 3)
end A
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaSplitLetTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  localDefinitionList at: 1
]

{ #category : #accessing }
ViennaSplitLetTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  localDefinitionList at: 2
]

{ #category : #accessing }
ViennaSplitLetTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	op : () ==> ()
	op() == let x:nat = 0 in let y:nat = 1 in (x := 2; y := 3)
end A
' asViennaDocumentAst
]

{ #category : #running }
ViennaSplitLetTest >> setupRefactoring: aViennaRefactoring [

	
]
