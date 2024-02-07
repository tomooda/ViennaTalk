Class {
	#name : #ViennaApplyNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaApplyNodeTest >> testMaximalType [

	| f fx fxy |
	f := 'f()' asViennaExpressionAst.
	fx := 'f(x)' asViennaExpressionAst.
	fxy := 'f(x, y)' asViennaExpressionAst.
	self assert: f isViennaApplyNode.
	self assert: fx isViennaApplyNode.
	self assert: fxy isViennaApplyNode.

	f expression maximalType: ViennaType unit -> ViennaType char.
	self assert: f maximalType equals: ViennaType char.

	fx expression maximalType: ViennaType nat -> ViennaType char.
	fx arguments first maximalType: ViennaType real.
	self assert: fx maximalType equals: ViennaType char.

	fxy expression maximalType:
		ViennaType nat * ViennaType token optional -> ViennaType char.
	fxy arguments first maximalType: ViennaType real.
	fxy arguments second maximalType: ViennaType token.
	self assert: fxy maximalType equals: ViennaType char.

	f expression maximalType: ViennaType nat -> ViennaType char.
	self should: [ f maximalType ] raise: ViennaTypeError.

	fx expression maximalType: ViennaType unit -> ViennaType char.
	fx arguments first maximalType: ViennaType unit.
	self should: [ fx maximalType ] raise: ViennaTypeError.

	fx expression maximalType:
		ViennaType nat * ViennaType token optional -> ViennaType char.
	fx arguments first maximalType: ViennaType real.
	self should: [ fx maximalType ] raise: ViennaTypeError.

	fxy expression maximalType: ViennaType nat -> ViennaType char.
	fxy arguments first maximalType: ViennaType real.
	fxy arguments second maximalType: ViennaType token.
	self should: [ fxy maximalType ] raise: ViennaTypeError
]
