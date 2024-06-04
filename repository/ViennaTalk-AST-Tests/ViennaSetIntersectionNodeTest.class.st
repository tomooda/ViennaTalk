Class {
	#name : 'ViennaSetIntersectionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSetIntersectionNodeTest >> testMaximalType [

	| expr |
	expr := 's1 inter s2' asViennaExpressionAst.
	expr expression1 setMaximalType: ViennaType nat set.
	expr expression2 setMaximalType: ViennaType nat set.
	self assert: expr maximalType equals: ViennaType nat set.

	expr expression1 setMaximalType: ViennaType nat optional set.
	expr expression2 setMaximalType: ViennaType char optional set.
	self assert: expr maximalType equals: ViennaType nat optional set.

	expr expression1 setMaximalType: ViennaType nat optional set.
	expr expression2 setMaximalType: ViennaType nat set.
	self assert: expr maximalType equals: ViennaType nat set.

	expr expression1 setMaximalType: ViennaType nat set.
	expr expression2 setMaximalType: ViennaType char set.
	self should: [ expr maximalType ] raise: ViennaTypeError
]
