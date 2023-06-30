Class {
	#name : #ViennaExtractTypeTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractTypeTest >> createSpec [

	^ '
module A
exports all
definitions
functions
	r : (real * real) -> real
	r(mk_(x, y)) == (x * x + y * y) ** 0.5;
	d : (real * real) * (real * real) -> real
	d(p1, p2) == r(mk_(p1.#1-p2.#1, p1.#2-p2.#2));
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractTypeTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'r') expression
]

{ #category : #accessing }
ViennaExtractTypeTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'r') argumentType
]

{ #category : #accessing }
ViennaExtractTypeTest >> resultingSpec [

	^ '
module A
exports all
definitions
functions
	r : Point -> real
	r(mk_(x, y)) == (x * x + y * y) ** 0.5;
	d : (real*real) * (real*real) -> real
	d(p1, p2) == r(mk_(p1.#1-p2.#1, p1.#2-p2.#2));
types
	Point = real * real;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractTypeTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'Point'
]
