Class {
	#name : #ViennaMoveOperationTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaMoveOperationTest >> createSpec [

	^ '
module A
exports all
definitions
operations
	pure op1 : () ==> ()
	op1() == skip;
	pure op2 : () ==> ()
	op2() == skip;
end A
module B
imports from A operations op1:()==>();
exports all
definitions
operations
	op : () ==> ()
	op() == (A`op1(); skip)
end B
' asViennaDocumentAst
]

{ #category : #accessing }
ViennaMoveOperationTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op1') statement
]

{ #category : #accessing }
ViennaMoveOperationTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'op1'
]

{ #category : #accessing }
ViennaMoveOperationTest >> resultingSpec [

	^ '
module A
exports all
definitions
operations
	pure op2 : () ==> ()
	op2() == skip;
end A
module B
exports all
definitions
operations
	op : () ==> ()
	op() == (op1(); skip);
	pure op1 : () ==> ()
	op1() == skip;
end B
' asViennaDocumentAst
]

{ #category : #running }
ViennaMoveOperationTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring
		destinationModule: (spec moduleNamed: 'B');
		okToAddImports: true
]
