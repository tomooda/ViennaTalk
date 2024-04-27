Class {
	#name : #ViennaDclStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaDclStatementNodeTest >> testMaximalType [

	self
		assert: '(dcl x:nat; skip)' asViennaStatementAst first maximalType
		equals: ViennaType unit.
	self
		assert:
		'(dcl x:nat := 2; skip)' asViennaStatementAst first maximalType
		equals: ViennaType unit.
	self
		should: [
		'(dcl x:nat := nil; skip)' asViennaStatementAst first maximalType ]
		raise: ViennaTypeError
]
