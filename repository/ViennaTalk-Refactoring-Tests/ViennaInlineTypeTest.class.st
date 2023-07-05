Class {
	#name : #ViennaInlineTypeTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaInlineTypeTest >> createSpec [

	^ '
module A
exports all
definitions
types
	Point = real * real;
	PositivePoint = real * real inv mk_(x, y) == x >= 0 and y >= 0;
	Rect :: origin : Point extent : PositivePoint;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaInlineTypeTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'Rect')
		  typeDefinition fieldList second type
]

{ #category : #accessing }
ViennaInlineTypeTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'Rect')
		  typeDefinition fieldList first type
]

{ #category : #accessing }
ViennaInlineTypeTest >> resultingSpec [

	^ '
module A
exports all
definitions
types
	Point = real * real;
	PositivePoint = real * real inv mk_(x, y) == x >= 0 and y >= 0;
	Rect :: origin : real * real extent : PositivePoint;
end A' asViennaDocumentAst
]

{ #category : #running }
ViennaInlineTypeTest >> setupRefactoring: aViennaRefactoring [

	
]
