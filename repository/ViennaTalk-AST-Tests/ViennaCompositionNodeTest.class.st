Class {
	#name : #ViennaCompositionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaCompositionNodeTest >> testMaximalType [

	| f_comp_g |
	f_comp_g := 'f comp g' asViennaExpressionAst.

	f_comp_g expression1 setMaximalType:
		ViennaType nat -> ViennaType token.
	f_comp_g expression2 setMaximalType:
		ViennaType char -> ViennaType nat.
	self
		assert: f_comp_g maximalType
		equals: ViennaType char -> ViennaType token.

	f_comp_g expression1 setMaximalType:
		ViennaType nat -> ViennaType token.
	f_comp_g expression2 setMaximalType:
		ViennaType char * ViennaType real -> ViennaType nat.
	self
		assert: f_comp_g maximalType
		equals: ViennaType char * ViennaType real -> ViennaType token.

	f_comp_g expression1 setMaximalType:
		ViennaType unit -> ViennaType token.
	f_comp_g expression2 setMaximalType:
		ViennaType char -> ViennaType nat.
	self should: [ f_comp_g maximalType ] raise: ViennaTypeError.

	f_comp_g expression1 setMaximalType:
		ViennaType nat * ViennaType nat -> ViennaType token.
	f_comp_g expression2 setMaximalType:
		ViennaType char -> ViennaType nat.
	self should: [ f_comp_g maximalType ] raise: ViennaTypeError
]
