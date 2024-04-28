"
A ViennaSymbolicLiteralNodeTest is a test class for testing the behavior of ViennaSymbolicLiteralNode
"
Class {
	#name : #ViennaSymbolicLiteralNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaSymbolicLiteralNodeTest >> testMaximalType [

	self
		assert: 'true' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		assert: 'false' asViennaExpressionAst maximalType
		equals: ViennaType bool.
	self
		assert: 'nil' asViennaExpressionAst maximalType
		equals: ViennaType unit optional.
	self
		assert: '''c''' asViennaExpressionAst maximalType
		equals: ViennaType char.
	self
		assert: '"string"' asViennaExpressionAst maximalType
		equals: ViennaType char seq1.
	self
		assert: '""' asViennaExpressionAst maximalType
		equals: ViennaType unit seq.
	self
		assert: '1' asViennaExpressionAst maximalType
		equals: ViennaType nat1.
	self
		assert: '0' asViennaExpressionAst maximalType
		equals: ViennaType nat.
	self
		assert: '-1' asViennaExpressionAst maximalType
		equals: ViennaType int.
	self
		assert: '1.0' asViennaExpressionAst maximalType
		equals: ViennaType real.
	self
		assert: '-3.14e-8' asViennaExpressionAst maximalType
		equals: ViennaType real
]
