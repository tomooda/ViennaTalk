Class {
	#name : #ViennaExtractValueTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractValueTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	area : real -> real
	area(r) == 3.14 * (r * r);
	cl : real -> real
	cl(r) == 2 * 3.14 * r;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractValueTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'area') expression expression2
]

{ #category : #accessing }
ViennaExtractValueTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'area') expression
		  expression1
]

{ #category : #accessing }
ViennaExtractValueTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	area : real -> real
	area(r) == pi * (r * r);
	cl : real -> real
	cl(r) == 2 * 3.14 * r;
values
	pi = 3.14;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractValueTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'pi'
]
