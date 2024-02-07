Class {
	#name : #ViennaCompositionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaCompositionNodeTest >> testMaximalType [

	| f_comp_g |
	f_comp_g := 'f comp g' asViennaExpressionAst.

	f_comp_g expression1 maximalType: ViennaType nat -> ViennaType token.
	f_comp_g expression2 maximalType: ViennaType char -> ViennaType nat.
	self
		assert: f_comp_g maximalType
		equals: ViennaType char -> ViennaType token.

	f_comp_g expression1 maximalType: ViennaType nat -> ViennaType token.
	f_comp_g expression2 maximalType:
		ViennaType char * ViennaType real -> ViennaType nat.
	self
		assert: f_comp_g maximalType
		equals: ViennaType char * ViennaType real -> ViennaType token.

	f_comp_g expression1 maximalType: ViennaType unit -> ViennaType token.
	f_comp_g expression2 maximalType: ViennaType char -> ViennaType nat.
	self should: [ f_comp_g maximalType ] raise: ViennaTypeError.

	f_comp_g expression1 maximalType:
		ViennaType nat * ViennaType nat -> ViennaType token.
	f_comp_g expression2 maximalType: ViennaType char -> ViennaType nat.
	self should: [ f_comp_g maximalType ] raise: ViennaTypeError
]
