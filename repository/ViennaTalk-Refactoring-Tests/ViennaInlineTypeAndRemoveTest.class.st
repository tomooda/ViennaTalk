Class {
	#name : #ViennaInlineTypeAndRemoveTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaInlineTypeAndRemoveTest >> createSpec [

	^ '
module A
exports all
definitions
types
	Point = real * real;
	PositivePoint = Point inv mk_(x, y) == x >= 0 and y >= 0;
	Rect :: origin : Point extent : PositivePoint;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaInlineTypeAndRemoveTest >> findFailureAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'PositivePoint'
]

{ #category : #accessing }
ViennaInlineTypeAndRemoveTest >> findSuccessAst [

	^ (self spec moduleNamed: 'A') resolveIdentifier: 'Point'
]

{ #category : #accessing }
ViennaInlineTypeAndRemoveTest >> resultingSpec [

	^ '
module A
exports all
definitions
types
	PositivePoint = real * real inv mk_(x, y) == x >= 0 and y >= 0;
	Rect :: origin : real * real extent : PositivePoint;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaInlineTypeAndRemoveTest >> setupRefactoring: aViennaRefactoring [

	
]
