Class {
	#name : #ViennaExtractValueAndReplaceAllTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractValueAndReplaceAllTest >> createSpec [

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
ViennaExtractValueAndReplaceAllTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'area') expression expression2
]

{ #category : #accessing }
ViennaExtractValueAndReplaceAllTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'area') expression
		  expression1
]

{ #category : #accessing }
ViennaExtractValueAndReplaceAllTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	area : real -> real
	area(r) == pi * (r * r);
	cl : real -> real
	cl(r) == 2 * pi * r;
values
	pi = 3.14;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractValueAndReplaceAllTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'pi'
]
