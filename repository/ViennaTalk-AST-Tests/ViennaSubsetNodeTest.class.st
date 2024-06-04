Class {
	#name : 'ViennaSubsetNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSubsetNodeTest >> testMaximalType [

	| expr |
	expr := 's1 subset s2' asViennaExpressionAst.
	expr expression1 setMaximalType: ViennaType nat set.
	expr expression2 setMaximalType: ViennaType nat set.
	self assert: expr maximalType equals: ViennaType bool.

	expr expression1 setMaximalType: ViennaType nat optional set.
	expr expression2 setMaximalType: ViennaType char optional set.
	self assert: expr maximalType equals: ViennaType bool.

	expr expression1 setMaximalType: ViennaType nat set.
	expr expression2 setMaximalType: ViennaType char set.
	self should: [ expr maximalType ] raise: ViennaTypeError
]
