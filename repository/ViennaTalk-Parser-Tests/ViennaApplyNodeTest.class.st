Class {
	#name : #ViennaApplyNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaApplyNodeTest >> testTypecheck [

	| f fx fxy |
	f := 'f()' asViennaExpressionAst.
	fx := 'f(x)' asViennaExpressionAst.
	fxy := 'f(x, y)' asViennaExpressionAst.
	self assert: f isViennaApplyNode.
	self assert: fx isViennaApplyNode.
	self assert: fxy isViennaApplyNode.

	f expression type: ViennaType unit -> ViennaType char.
	self assert: f typecheck equals: ViennaType char.

	fx expression type: ViennaType nat -> ViennaType char.
	fx arguments first type: ViennaType real.
	self assert: fx typecheck equals: ViennaType char.

	fxy expression type:
		ViennaType nat * ViennaType token optional -> ViennaType char.
	fxy arguments first type: ViennaType real.
	fxy arguments second type: ViennaType token.
	self assert: fxy typecheck equals: ViennaType char.

	f expression type: ViennaType nat -> ViennaType char.
	self should: [ f typecheck ] raise: ViennaTypeError.

	fx expression type: ViennaType unit -> ViennaType char.
	fx arguments first type: ViennaType unit.
	self should: [ fx typecheck ] raise: ViennaTypeError.

	fx expression type:
		ViennaType nat * ViennaType token optional -> ViennaType char.
	fx arguments first type: ViennaType real.
	self should: [ fx typecheck ] raise: ViennaTypeError.

	fxy expression type: ViennaType nat -> ViennaType char.
	fxy arguments first type: ViennaType real.
	fxy arguments second type: ViennaType token.
	self should: [ fxy typecheck ] raise: ViennaTypeError
]
